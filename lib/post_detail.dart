import 'package:dzaubry_newspaper/navbar%20screens/profile.dart';
import 'package:dzaubry_newspaper/navbar%20screens/sidemenu.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.add_circle),
          //   tooltip: 'Show Snackbar',
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('This is a snackbar')));
          //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BottomNavBar()));
          //   },
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Row(
                          children: [
                            Image.asset("assets/icons/eu-news.png", height: 45, width: 45,),
                            Text(" E.U News ", style: TextStyle(fontWeight: FontWeight.bold),),
                            Image.asset("assets/icons/verified.png", height: 15, width: 15,),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: width*0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: primaryColor
                              ),
                              alignment: Alignment.center,
                              child: const Text("Seguir",style: TextStyle(fontSize:10,color: colorWhite),),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              height: 30,
                              width: width*0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: colorBlack)
                              ),
                              alignment: Alignment.center,
                              child: const Text("Dejar de seguir",style: TextStyle(fontSize:10,color: colorBlack),),
                            ),
                          ],
                        )
                      )

                    ],
                  ),
                  SizedBox(height: 10,),
                  Text("11:45 AM", textAlign: TextAlign.left, style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),

                  Container(
                    height: 200,
                    width: width*0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage("assets/images/car.png"),
                        fit: BoxFit.cover,
                      ),
                    ),

                  ),
                  SizedBox(height: 10,),
                  Text("El presidente Hernández visita la UE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),

                  SizedBox(height: 10,),
                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. \n\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                  SizedBox(height: 10,),
                  Container(
                    height: 50,
                    width: width*0.35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: colorBlack)
                    ),
                    alignment: Alignment.center,
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Ver video",style: TextStyle(fontSize:14,color: colorBlack),),
                        Image.asset("assets/images/video.png", height: 45, width: 45,),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.thumb_up_alt_outlined),
                          SizedBox(width: 5,),
                          Text("98", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.thumb_down_alt_outlined),
                          SizedBox(width: 5,),
                          Text("32", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.comment),
                          SizedBox(width: 5,),
                          Text("76", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                        ],
                      ),
                      Icon(Icons.share),

                    ],
                  ),
                  SizedBox(height: 20,),
                  Text("Noticias relacionadas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                  SizedBox(height: 20,),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage("assets/images/army.png"),
                                fit: BoxFit.cover,
                              ),
                            ),

                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Qué sigue para Ucrania?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                              SizedBox(height: 10,),
                              Container(
                                height: 30,
                                width: width*0.15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: colorBlack)
                                ),
                                alignment: Alignment.center,
                                child: const Text("leer",style: TextStyle(fontSize:18,color: colorBlack),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage("assets/images/army.png"),
                                fit: BoxFit.cover,
                              ),
                            ),

                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Qué sigue para Ucrania?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                              SizedBox(height: 10,),
                              Container(
                                height: 30,
                                width: width*0.15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: colorBlack)
                                ),
                                alignment: Alignment.center,
                                child: const Text("leer",style: TextStyle(fontSize:18,color: colorBlack),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage("assets/images/army.png"),
                                fit: BoxFit.cover,
                              ),
                            ),

                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Qué sigue para Ucrania?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                              SizedBox(height: 10,),
                              Container(
                                height: 30,
                                width: width*0.15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: colorBlack)
                                ),
                                alignment: Alignment.center,
                                child: const Text("leer",style: TextStyle(fontSize:18,color: colorBlack),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
