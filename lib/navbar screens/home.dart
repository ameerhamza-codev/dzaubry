import 'package:dzaubry_newspaper/navbar%20screens/profile.dart';
import 'package:dzaubry_newspaper/navbar%20screens/sidemenu.dart';
import 'package:dzaubry_newspaper/post_detail.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorWhite,
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: const Text('Dzaubry', style: TextStyle( color: primaryColor, fontSize: 24),),
        centerTitle: true,
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
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'Qué quieres leer?',
                fillColor: colorWhite,
                filled: true,

              ),
            ),
            SizedBox(height: 20,),
            DefaultTabController(
                length: 4, // length of tabs
                initialIndex: 0,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                  Container(
                    child: TabBar(
                      labelColor: primaryColor,
                      unselectedLabelColor: Colors.black,
                        indicatorColor: primaryColor,

                        tabs: [
                        Tab(child:Text('Para usted', style: TextStyle(color: colorBlack, fontSize: 11, fontWeight: FontWeight.w600),)),
                        Tab(child: Text('Tendencias', style: TextStyle(color: colorBlack, fontSize: 11, fontWeight: FontWeight.w600),)),
                        Tab(child: Text('Deportes', style: TextStyle(color: colorBlack, fontSize: 11, fontWeight: FontWeight.w600),)),
                        Tab(child: Text('Politics', style: TextStyle(color: colorBlack, fontSize: 11, fontWeight: FontWeight.w600),)),]
                    ),
                  ),
                  Container(
                      height: 500, //height of TabBarView
                      decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                      ),
                      child: TabBarView(children: <Widget>[
                        Container(
                          child:
                          ListView(
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Row(
                                            children: [
                                              Image.asset("assets/icons/eu-news.png", height: 45, width: 45,),
                                              Text(" E.U News ", style: TextStyle(fontWeight: FontWeight.bold),),
                                              Image.asset("assets/icons/verified.png", height: 15, width: 15,),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text("11:45 AM", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold),),
                                        )

                                      ],
                                    ),
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
                                    Text("El presidente Hernández visita la UE", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),

                                    SizedBox(height: 10,),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PostDetail()));
                                      },
                                      child: Container(
                                        height: 30,
                                        width: width*0.15,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: colorBlack)
                                        ),
                                        alignment: Alignment.center,
                                        child: const Text("leer",style: TextStyle(fontSize:18,color: colorBlack),),
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
                                    )

                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Row(
                                            children: [
                                              Image.asset("assets/icons/eu-news.png", height: 45, width: 45,),
                                              Text(" E.U News ", style: TextStyle(fontWeight: FontWeight.bold),),
                                              Image.asset("assets/icons/verified.png", height: 15, width: 15,),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text("11:45 AM", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold),),
                                        )

                                      ],
                                    ),
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
                                    Text("El presidente Hernández visita la UE", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),

                                    SizedBox(height: 10,),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PostDetail()));
                                      },
                                      child: Container(
                                        height: 30,
                                        width: width*0.15,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: colorBlack)
                                        ),
                                        alignment: Alignment.center,
                                        child: const Text("leer",style: TextStyle(fontSize:18,color: colorBlack),),
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
                                    )

                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Row(
                                            children: [
                                              Image.asset("assets/icons/eu-news.png", height: 45, width: 45,),
                                              Text(" E.U News ", style: TextStyle(fontWeight: FontWeight.bold),),
                                              Image.asset("assets/icons/verified.png", height: 15, width: 15,),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text("11:45 AM", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold),),
                                        )

                                      ],
                                    ),
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
                                    Text("El presidente Hernández visita la UE", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),

                                    SizedBox(height: 10,),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PostDetail()));
                                      },
                                      child: Container(
                                        height: 30,
                                        width: width*0.15,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: colorBlack)
                                        ),
                                        alignment: Alignment.center,
                                        child: const Text("leer",style: TextStyle(fontSize:18,color: colorBlack),),
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
                                    )

                                  ],
                                ),
                              ),
                              SizedBox(height: 50,)
                            ],
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text('Pestaña 2', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text('Pestaña 3', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text('Pestaña 4', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ])
                  )
                ])
            ),
          ],
        ),
      ),
    );
  }
}
