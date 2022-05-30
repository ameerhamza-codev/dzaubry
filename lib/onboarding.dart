import 'package:dzaubry_newspaper/login.dart';
import 'package:dzaubry_newspaper/utils/constants.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),

        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 90.0),
                  child:  RichText(
                    text: const TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                         TextSpan(text:"Obtén todas las novedades y actualizaciones que quieras desde el confort de tu hogar con", style: TextStyle(
                          color: secondaryColor,
                          fontSize: 20,
                        ),),
                         TextSpan(text: ' Dzuabry', style: TextStyle(
                          color: secondaryColor,
                          fontSize: 28,
                        ),),
                      ],
                    ),
                  )
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  Login()));
                  },
                  child: Container(
                    height: 50,
                    width: width*0.35,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: const Text("Proceder",style: TextStyle(fontSize:22,color: secondaryColor),),
                  ),
                ),
                SizedBox(height: 50,),

              ],
            ),
          ),

        )
      ],
      );
  }
}
