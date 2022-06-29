import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dzaubry_newspaper/bottomnav.dart';
import 'package:dzaubry_newspaper/interests.dart';
import 'package:dzaubry_newspaper/provider/userdataprovider.dart';
import 'package:dzaubry_newspaper/register.dart';
import 'package:dzaubry_newspaper/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import 'models/user_model.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var _emailController=TextEditingController();
  var _passwordController=TextEditingController();

  bool _isObscure = true;
  bool checkedValue = true;

  //function
  login()async{
    final ProgressDialog pr = ProgressDialog(context: context);
    pr.show(max: 100, msg: 'Iniciando sesión');
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text
    ).then((value)async{
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((DocumentSnapshot documentSnapshot) async{
        if (documentSnapshot.exists) {
          pr.close();
          Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
          AppUser user=AppUser.fromMap(data,documentSnapshot.reference.id);
          final provider = Provider.of<UserDataProvider>(context, listen: false);
          provider.setUserData(user);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => BottomNavBar()));

        }
        else{
          pr.close();
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: "No User Data",
          );
        }
      });

      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => TeacherBar()));
    }).onError((error, stackTrace){
      pr.close();
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: error.toString(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Size _size= MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              child: Padding(
                padding: _size.width> 756 ? EdgeInsets.symmetric(horizontal: width*0.2):EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100,),
                      Text("INICIAR SESIÓN", style: TextStyle(
                          color: colorBlack,
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                      ),),
                      const SizedBox(height: 40,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email!';
                          }
                          return null;
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          hintText: 'Email',
                          fillColor: colorWhite,
                          filled: true,

                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        obscureText: _isObscure,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }

                          return null;
                        },
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          hintText: 'Contraseña',
                          fillColor: colorWhite,
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: checkedValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    checkedValue = newValue!;
                                  });
                                },
                              ),
                              Text("Recuérdame"),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const ForgotPassword()));
                            },
                            child: const Text("Olvidé mi contraseña?", style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),),
                          ),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Center(
                        child: InkWell(
                          onTap: (){
                            if(_formKey.currentState!.validate()){
                              login();
                            }
                          },
                          child: Container(
                            height: 40,
                            width: _size.width> 756? width*0.4:width*0.8,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: const Text("Inicia Session",style: TextStyle(fontSize:22,color: colorWhite),),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),

            ),
            const SizedBox(height: 10,),
            Center(
              child: Image.asset("assets/icons/or.png", height: 20,),
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Image.asset("assets/icons/facebook.png", height: 40, width: 40,),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Image.asset("assets/icons/twitter.png", height: 40, width: 40,),
                ),
                Image.asset("assets/icons/insta.png", height: 40, width: 40,),
              ],
            ),
            const SizedBox(height: 40,),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Center(
                        child:Text("No tienes una cuenta?", style: TextStyle(color: colorBlack, fontSize: 14, fontWeight: FontWeight.w600),)
                    ),
                  ),
                  Center(
                      child:InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Register()));
                          },
                          child:  Text("Crear uno", style: TextStyle(color: colorBlack.withOpacity(0.8), fontSize: 14),)
                      )
                  ),
                ],
              ),
            )
          ],
        ),

      ),
    );
  }
}


///functions

