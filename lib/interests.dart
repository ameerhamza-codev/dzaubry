import 'package:dzaubry_newspaper/bottomnav.dart';
import 'package:dzaubry_newspaper/utils/constants.dart';
import 'package:flutter/material.dart';

class Interest extends StatefulWidget {
  const Interest({Key? key}) : super(key: key);

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: secondaryColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const SizedBox(height: 10,),
              Text("Bienvenido Sergio, antes de crear tu feed", style: TextStyle(
                color: colorBlack,
                fontSize: 18,
                fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Elija su interés", style: TextStyle(
                      color: colorBlack,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BottomNavBar()));
                    },
                    child: Container(
                      height: 40,
                      width: width*0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: colorBlack,)
                      ),
                      alignment: Alignment.center,
                      child: const Text("Hecho",style: TextStyle(fontSize:16,color: colorBlack),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Text("Puede seleccionar varias opciones", style: TextStyle(
                  color: colorBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: width*0.45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryColor
                    ),
                    alignment: Alignment.center,
                    child: const Text("Deportes",style: TextStyle(fontSize:18,color: colorWhite),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: Container(
                      height: 50,
                      width: width*0.40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: primaryColor
                      ),
                      alignment: Alignment.center,
                      child: const Text("Música",style: TextStyle(fontSize:18,color: colorWhite),),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: width*0.38,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryColor
                    ),
                    alignment: Alignment.center,
                    child: const Text("Política",style: TextStyle(fontSize:18,color: colorWhite),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: Container(
                      height: 50,
                      width: width*0.52,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: primaryColor
                      ),
                      alignment: Alignment.center,
                      child: const Text("Modo de vida",style: TextStyle(fontSize:18,color: colorWhite),),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: width*0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: colorBlack)
                    ),
                    alignment: Alignment.center,
                    child: const Text("Locales",style: TextStyle(fontSize:18,color: colorBlack),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: Container(
                      height: 50,
                      width: width*0.45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: primaryColor
                      ),
                      alignment: Alignment.center,
                      child: const Text("Eventos sociales",style: TextStyle(fontSize:18,color: colorWhite),),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: width*0.55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryColor
                    ),
                    alignment: Alignment.center,
                    child: const Text("Medicina y Salud",style: TextStyle(fontSize:18,color: colorWhite),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: Container(
                      height: 50,
                      width: width*0.30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: primaryColor
                      ),
                      alignment: Alignment.center,
                      child: const Text("Historia",style: TextStyle(fontSize:18,color: colorWhite),),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: width*0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryColor
                    ),
                    alignment: Alignment.center,
                    child: const Text("Tecnología",style: TextStyle(fontSize:18,color: colorWhite),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: Container(
                      height: 50,
                      width: width*0.30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: primaryColor
                      ),
                      alignment: Alignment.center,
                      child: const Text("General",style: TextStyle(fontSize:18,color: colorWhite),),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: width*0.45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: colorBlack)
                    ),
                    alignment: Alignment.center,
                    child: const Text("Amor&Relación",style: TextStyle(fontSize:18,color: colorBlack),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: Container(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: width*0.20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryColor
                    ),
                    alignment: Alignment.center,
                    child: const Text("Cine",style: TextStyle(fontSize:18,color: colorWhite),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: Container(
                      height: 50,
                      width: width*0.40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: colorBlack)
                      ),
                      alignment: Alignment.center,
                      child: const Text("Tiempo y Clima",style: TextStyle(fontSize:18,color: colorBlack),),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: width*0.35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryColor,
                    ),
                    alignment: Alignment.center,
                    child: const Text("Educación",style: TextStyle(fontSize:18,color: colorWhite),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 68.0),
                    child: Container(),
                  ),
                ],
              ),



            ],
          ),
        ),

      ),
    );
  }
}
