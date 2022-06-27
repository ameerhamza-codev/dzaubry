import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dzaubry_newspaper/models/post_model.dart';
import 'package:dzaubry_newspaper/navbar%20screens/sidemenu.dart';
import 'package:dzaubry_newspaper/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/userdataprovider.dart';
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
    Size _size= MediaQuery.of(context).size;
    final provider = Provider.of<UserDataProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: colorWhite,
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: const Text('Dzuabry', style: TextStyle( color: primaryColor, fontSize: 24),),
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
        padding: _size.width> 756 ? EdgeInsets.symmetric(horizontal: width*0.15):EdgeInsets.all(15.0),
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
                      height: _size.width> 756 ? _size.height-50: 500, //height of TabBarView
                      decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                      ),
                      child: TabBarView(children: <Widget>[
                        Container(
                          child:
                          ListView(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('posts')
                                    .snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(child: Text('Something went wrong'));
                                  }

                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.data!.size==0) {
                                    return Center(child: Text('No Posts'));
                                  }
                                  return ListView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(20),

                                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                      PostModel story=PostModel.fromMap(data, document.reference.id);

                                      return Container(
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
                                                      Container(
                                                        height: 45,
                                                        width: 45,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(50),
                                                          image: const DecorationImage(
                                                            image: AssetImage("assets/images/profile.png"),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),

                                                      ),
                                                      Text(" ${story.username} ", style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Image.asset("assets/icons/verified.png", height: 15, width: 15,),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Text(timeAgoSinceDate(DateTime.fromMillisecondsSinceEpoch(story.time).toString()), textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold),),
                                                )

                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                              height: _size.width> 756 ? 400 : 200, //height of TabBarView
                                              width: width*0.9,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    story.image
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),

                                            ),
                                            SizedBox(height: 10,),
                                            Text(story.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),

                                            SizedBox(height: 10,),
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PostDetail(post: story,)));
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
                                            SizedBox(height: 40,),

                                            Row(
                                              mainAxisAlignment: _size.width> 756 ? MainAxisAlignment.spaceAround: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.thumb_up_alt_outlined),
                                                    SizedBox(width: 5,),
                                                    Text("0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.arrow_upward),
                                                    Icon(Icons.arrow_downward),
                                                    SizedBox(width: 5,),
                                                    Text("Votar 0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.comment),
                                                    SizedBox(width: 5,),
                                                    Text(story.comments.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                                  ],
                                                ),
                                                Icon(Icons.share),

                                              ],
                                            )

                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                              SizedBox(height: 50,)
                            ],
                          ),
                        ),
                        Container(
                          child: ListView(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('posts')
                                    .snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(child: Text('Something went wrong'));
                                  }

                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.data!.size==0) {
                                    return Center(child: Text('Sin publicaciones'));
                                  }
                                  return ListView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(20),

                                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                      PostModel story=PostModel.fromMap(data, document.reference.id);

                                      return Container(
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
                                                      Container(
                                                        height: 45,
                                                        width: 45,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(50),
                                                          image: const DecorationImage(
                                                            image: AssetImage("assets/images/profile.png"),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),

                                                      ),
                                                      Text(" ${story.username} ", style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Image.asset("assets/icons/verified.png", height: 15, width: 15,),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Text(timeAgoSinceDate(DateTime.fromMillisecondsSinceEpoch(story.time).toString()), textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold),),
                                                )

                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                              height: _size.width> 756 ? 400 : 200, //height of TabBarView
                                              width: width*0.9,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      story.image
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),

                                            ),
                                            SizedBox(height: 10,),
                                            Text(story.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),

                                            SizedBox(height: 10,),
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PostDetail(post: story,)));
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
                                            SizedBox(height: 40,),

                                            Row(
                                              mainAxisAlignment: _size.width> 756 ? MainAxisAlignment.spaceAround: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.thumb_up_alt_outlined),
                                                    SizedBox(width: 5,),
                                                    Text("0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.arrow_upward),
                                                    Icon(Icons.arrow_downward),
                                                    SizedBox(width: 5,),
                                                    Text("Votar 0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.comment),
                                                    SizedBox(width: 5,),
                                                    Text(story.comments.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                                  ],
                                                ),
                                                Icon(Icons.share),

                                              ],
                                            )

                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                              SizedBox(height: 50,)
                            ],
                          ),
                        ),
                        Container(
                          child: ListView(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('posts')
                                    .where("categoryName",isEqualTo: "Deportes").snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(child: Text('Something went wrong'));
                                  }

                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.data!.size==0) {
                                    return const Center(child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 50.0),
                                      child: Text('Sin publicaciones'),
                                    ));
                                  }
                                  return ListView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(20),

                                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                      PostModel story=PostModel.fromMap(data, document.reference.id);

                                      return Container(
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
                                                      Container(
                                                        height: 45,
                                                        width: 45,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(50),
                                                          image: const DecorationImage(
                                                            image: AssetImage("assets/images/profile.png"),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),

                                                      ),
                                                      Text(" ${story.username} ", style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Image.asset("assets/icons/verified.png", height: 15, width: 15,),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Text(timeAgoSinceDate(DateTime.fromMillisecondsSinceEpoch(story.time).toString()), textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold),),
                                                )

                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                              height: _size.width> 756 ? 400 : 200, //height of TabBarView
                                              width: width*0.9,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      story.image
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),

                                            ),
                                            SizedBox(height: 10,),
                                            Text(story.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),

                                            SizedBox(height: 10,),
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PostDetail(post: story,)));
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
                                            SizedBox(height: 40,),

                                            Row(
                                              mainAxisAlignment: _size.width> 756 ? MainAxisAlignment.spaceAround: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.thumb_up_alt_outlined),
                                                    SizedBox(width: 5,),
                                                    Text("0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.arrow_upward),
                                                    Icon(Icons.arrow_downward),
                                                    SizedBox(width: 5,),
                                                    Text("Votar 0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.comment),
                                                    SizedBox(width: 5,),
                                                    Text(story.comments.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                                  ],
                                                ),
                                                Icon(Icons.share),

                                              ],
                                            )

                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                              SizedBox(height: 50,)
                            ],
                          ),
                        ),
                        Container(
                          child: ListView(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('posts')
                                    .where("categoryName",isEqualTo: "Politics").snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(child: Text('Something went wrong'));
                                  }

                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.data!.size==0) {
                                    return Center(child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                                      child: Text('Sin publicaciones'),
                                    ));
                                  }
                                  return ListView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(20),

                                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                      PostModel story=PostModel.fromMap(data, document.reference.id);

                                      return Container(
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
                                                      Container(
                                                        height: 45,
                                                        width: 45,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(50),
                                                          image: const DecorationImage(
                                                            image: AssetImage("assets/images/profile.png"),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),

                                                      ),
                                                      Text(" ${story.username} ", style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Image.asset("assets/icons/verified.png", height: 15, width: 15,),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Text(timeAgoSinceDate(DateTime.fromMillisecondsSinceEpoch(story.time).toString()), textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold),),
                                                )

                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                              height: _size.width> 756 ? 400 : 200, //height of TabBarView
                                              width: width*0.9,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      story.image
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),

                                            ),
                                            SizedBox(height: 10,),
                                            Text(story.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),

                                            SizedBox(height: 10,),
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PostDetail(post: story,)));
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
                                            SizedBox(height: 40,),

                                            Row(
                                              mainAxisAlignment: _size.width> 756 ? MainAxisAlignment.spaceAround: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.thumb_up_alt_outlined),
                                                    SizedBox(width: 5,),
                                                    Text("0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.arrow_upward),
                                                    Icon(Icons.arrow_downward),
                                                    SizedBox(width: 5,),
                                                    Text("Votar 0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.comment),
                                                    SizedBox(width: 5,),
                                                    Text(story.comments.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                                  ],
                                                ),
                                                Icon(Icons.share),

                                              ],
                                            )

                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                              SizedBox(height: 50,)
                            ],
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
