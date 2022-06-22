import 'package:dzaubry_newspaper/interests.dart';
import 'package:dzaubry_newspaper/register.dart';
import 'package:dzaubry_newspaper/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  bool checkedValue = false;

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
                    TextField(
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
                    TextField(
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
                           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  Interest()));
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
