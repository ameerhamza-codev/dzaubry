import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dzaubry_newspaper/bottomnav.dart';
import 'package:dzaubry_newspaper/login.dart';
import 'package:dzaubry_newspaper/models/user_model.dart';
import 'package:dzaubry_newspaper/provider/userdataprovider.dart';
import 'package:dzaubry_newspaper/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isObscure = true;
  var _emailController=TextEditingController();
  var _passwordController=TextEditingController();
  var _confirmPasswordController=TextEditingController();
  var _usernameController=TextEditingController();
  var _firstNameController=TextEditingController();
  var _lastNameController=TextEditingController();
  final _formKey = GlobalKey<FormState>();

  register()async{
    final ProgressDialog pr = ProgressDialog(context: context);
    pr.show(max: 100, msg: 'Registering');
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    ).then((value)async{
      await FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({

        "firstName":_firstNameController.text,
        "lastName":_lastNameController.text,
        "userName":_usernameController.text,
        "email":_emailController.text,
        "password":_passwordController.text,
        "profileURL": "https://st3.depositphotos.com/9998432/13335/v/600/depositphotos_133352010-stock-illustration-default-placeholder-man-and-woman.jpg"

      });
      final provider = Provider.of<UserDataProvider>(context, listen: false);

      AppUser model= AppUser(
          value.user!.uid,
          _firstNameController.text,
          _lastNameController.text,
          _usernameController.text,
          _emailController.text,
          _passwordController.text,
          "https://st3.depositphotos.com/9998432/13335/v/600/depositphotos_133352010-stock-illustration-default-placeholder-man-and-woman.jpg"
      );
      provider.setUserData(model);
      // provider.setCategory("All Categories");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => BottomNavBar()));
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
                      const SizedBox(height: 40,),
                      Text("ÚNETE", style: TextStyle(
                          color: colorBlack,
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                      ),),
                      const SizedBox(height: 30,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field Can\'t be empty!';
                          }
                          return null;
                        },
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          hintText: 'Primer nombre',
                          fillColor: colorWhite,
                          filled: true,

                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field Can\'t be empty!';
                          }
                          return null;
                        },
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          hintText: 'Apellido',
                          fillColor: colorWhite,
                          filled: true,

                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field Can\'t be empty!';
                          }
                          return null;
                        },
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          hintText: 'Nombre de usuario',
                          fillColor: colorWhite,
                          filled: true,

                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field Can\'t be empty!';
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
                      const SizedBox(height: 10,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field Can\'t be empty!';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        obscureText: _isObscure,
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
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field Can\'t be empty!';
                          }
                          return null;
                        },
                        controller: _confirmPasswordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          border:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          hintText: 'Confirmar Contraseña',
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
                      const SizedBox(height: 30,),
                      Center(
                        child: InkWell(
                          onTap: (){
                            if(_formKey.currentState!.validate()){
                              if(_passwordController.text.toString()==_confirmPasswordController.text.toString()){
                                register();
                              }
                              else {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: 'Passwords Don\'t Match!'
                                );
                              }
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
                            child: const Text("Únete",style: TextStyle(fontSize:22,color: colorWhite),),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),

            ),
            SizedBox(height: 10,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Center(
                        child:Text("Ya tienes una cuenta?", style: TextStyle(color: colorBlack, fontSize: 14, fontWeight: FontWeight.w600),)
                    ),
                  ),
                  Center(
                      child:InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Login()));
                          },
                          child:  Text("Inicia sesión", style: TextStyle(color: colorBlack.withOpacity(0.8), fontSize: 14),)
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
