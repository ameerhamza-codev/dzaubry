import 'package:dzaubry_newspaper/login.dart';
import 'package:dzaubry_newspaper/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isObscure = true;
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
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
                    TextField(
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
                    TextField(
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
                    TextField(
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
                    const SizedBox(height: 10,),
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
                    TextField(
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
                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  BottomNavBar()));
                        },
                        child: Container(
                          height: 40,
                          width: width*0.8,
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
