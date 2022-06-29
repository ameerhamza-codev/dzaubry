import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dzaubry_newspaper/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PostDetail extends StatefulWidget {
  final PostModel post;
  const PostDetail({Key? key, required this.post}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Size _size= MediaQuery.of(context).size;
    var _commentController=TextEditingController();
    int commentCounter=widget.post.comments;
    final _formKey = GlobalKey<FormState>();


    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        actions: <Widget>[

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            Container(
              child:Padding(
                      padding: _size.width> 756 ? EdgeInsets.symmetric(horizontal: width*0.2):EdgeInsets.all(15.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Expanded(
                                  flex:  _size.width> 756? 6:5,
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
                                      Text(" ${widget.post.username} ", style: TextStyle(fontWeight: FontWeight.bold),),
                                      Image.asset("assets/icons/verified.png", height: 15, width: 15,),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    flex:  _size.width> 756? 4:5,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: _size.width> 756? width*0.1:width*0.2,
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
                                          width: _size.width> 756? width*0.1:width*0.2,
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
                            Text(timeAgoSinceDate(DateTime.fromMillisecondsSinceEpoch(widget.post.time).toString()), textAlign: TextAlign.left, style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),

                            widget.post.image=="" ?
                            Container(
                              height: _size.width> 756 ? 400 : 200, //height of TabBarView
                              width: width*0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/no_image.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),

                            )
                                : Container(
                              height: _size.width> 756 ? 400 : 200, //height of TabBarView
                              width: width*0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      widget.post.image
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),

                            ),
                            SizedBox(height: 10,),
                            Text(widget.post.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),

                            SizedBox(height: 10,),
                            Text(widget.post.story, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                            SizedBox(height: 10,),
                            // Container(
                            //   height: 50,
                            //   width: _size.width> 756? width*0.15:width*0.35,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5),
                            //       border: Border.all(color: colorBlack)
                            //   ),
                            //   alignment: Alignment.center,
                            //   child:  Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //     children: [
                            //       Text("Ver video",style: TextStyle(fontSize:14,color: colorBlack),),
                            //       Image.asset("assets/images/video.png", height: 45, width: 45,),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(height: 30,),

                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('posts').where("story",isEqualTo: widget.post.story).snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const Center(child: Text('Something went wrong'));
                                  }
                                return Row(
                                  mainAxisAlignment: _size.width> 756 ? MainAxisAlignment.spaceAround: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.thumb_up_alt_outlined),
                                          onPressed: (){
                                            if(!widget.post.like.contains(FirebaseAuth.instance.currentUser!.uid)){
                                              if(widget.post.dislike.contains(FirebaseAuth.instance.currentUser!.uid)){
                                                List newRemoved=widget.post.dislike;
                                                List newAdd=widget.post.like;
                                                newRemoved.removeWhere((element) => element==FirebaseAuth.instance.currentUser!.uid);
                                                newAdd.add(FirebaseAuth.instance.currentUser!.uid);
                                                FirebaseFirestore.instance.collection('posts').doc(widget.post.id).update({
                                                  'like': newAdd,
                                                  'dislike': newRemoved,
                                                });
                                              }
                                              else{
                                                List newAdd=widget.post.like;

                                                newAdd.add(FirebaseAuth.instance.currentUser!.uid);
                                                FirebaseFirestore.instance.collection('posts').doc(widget.post.id).update({
                                                  'like': newAdd,
                                                });
                                              }
                                            }
                                          },
                                        ),
                                        SizedBox(width: 5,),
                                        Text(widget.post.like.length.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.thumb_down_alt_outlined),
                                          onPressed: (){
                                            if(!widget.post.dislike.contains(FirebaseAuth.instance.currentUser!.uid)){
                                              if(widget.post.like.contains(FirebaseAuth.instance.currentUser!.uid)){
                                                List newRemoved=widget.post.like;
                                                List newAdd=widget.post.dislike;
                                                newRemoved.removeWhere((element) => element==FirebaseAuth.instance.currentUser!.uid);
                                                newAdd.add(FirebaseAuth.instance.currentUser!.uid);
                                                FirebaseFirestore.instance.collection('posts').doc(widget.post.id).update({
                                                  'dislike': newAdd,
                                                  'like': newRemoved,
                                                });
                                              }
                                              else{
                                                List newAdd=widget.post.dislike;

                                                newAdd.add(FirebaseAuth.instance.currentUser!.uid);
                                                FirebaseFirestore.instance.collection('posts').doc(widget.post.id).update({
                                                  'dislike': newAdd,
                                                });
                                              }
                                            }
                                          },
                                        ),
                                        SizedBox(width: 5,),
                                        Text(widget.post.dislike.length.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.comment),
                                        SizedBox(width: 5,),
                                        Text(widget.post.comments.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                      ],
                                    ),
                                    Icon(Icons.share),

                                  ],
                                );
                              }
                            ),
                            SizedBox(height: 20,),


                            // Text("Noticias relacionadas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                            // SizedBox(height: 20,),
                            // Container(
                            //   width: _size.width> 756? width*0.3:width,
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(10.0),
                            //     child: Row(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //       children: [
                            //         Container(
                            //           height: 120,
                            //           width: 120,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(15),
                            //             image: DecorationImage(
                            //               image: AssetImage("assets/images/army.png"),
                            //               fit: BoxFit.cover,
                            //             ),
                            //           ),
                            //
                            //         ),
                            //         Column(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             Text("Qué sigue para Ucrania?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                            //             SizedBox(height: 10,),
                            //             Container(
                            //               height: 30,
                            //               width: width*0.15,
                            //               decoration: BoxDecoration(
                            //                   borderRadius: BorderRadius.circular(10),
                            //                   border: Border.all(color: colorBlack)
                            //               ),
                            //               alignment: Alignment.center,
                            //               child: const Text("leer",style: TextStyle(fontSize:18,color: colorBlack),),
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   width: _size.width> 756? width*0.3:width,
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(10.0),
                            //     child: Row(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //       children: [
                            //         Container(
                            //           height: 120,
                            //           width: 120,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(15),
                            //             image: DecorationImage(
                            //               image: AssetImage("assets/images/army.png"),
                            //               fit: BoxFit.cover,
                            //             ),
                            //           ),
                            //
                            //         ),
                            //         Column(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             Text("Qué sigue para Ucrania?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                            //             SizedBox(height: 10,),
                            //             Container(
                            //               height: 30,
                            //               width: width*0.15,
                            //               decoration: BoxDecoration(
                            //                   borderRadius: BorderRadius.circular(10),
                            //                   border: Border.all(color: colorBlack)
                            //               ),
                            //               alignment: Alignment.center,
                            //               child: const Text("leer",style: TextStyle(fontSize:18,color: colorBlack),),
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   width: _size.width> 756? width*0.3:width,
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(10.0),
                            //     child: Row(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //       children: [
                            //         Container(
                            //           height: 120,
                            //           width: 120,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(15),
                            //             image: DecorationImage(
                            //               image: AssetImage("assets/images/army.png"),
                            //               fit: BoxFit.cover,
                            //             ),
                            //           ),
                            //
                            //         ),
                            //         Column(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             Text("Qué sigue para Ucrania?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                            //             SizedBox(height: 10,),
                            //             Container(
                            //               height: 30,
                            //               width: width*0.15,
                            //               decoration: BoxDecoration(
                            //                   borderRadius: BorderRadius.circular(10),
                            //                   border: Border.all(color: colorBlack)
                            //               ),
                            //               alignment: Alignment.center,
                            //               child: const Text("leer",style: TextStyle(fontSize:18,color: colorBlack),),
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),


                          ],
                        ),
                      ),

                    )

            ),
            Container(child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: TextFormField(
                              controller: _commentController,
                              style: Theme.of(context).textTheme.subtitle2!.apply(color: Colors.black),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide(
                                      color: primaryColor,
                                      width: 0.5
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 0.5,
                                  ),
                                ),
                                hintText: "Enter Comment",
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                              ),
                            ),
                          )
                      ),
                      InkWell(
                        onTap: ()async{
                          if(_formKey.currentState!.validate())
                            {
                              await FirebaseFirestore.instance.collection('comments').add({
                                'postId': widget.post.id,
                                'comment': _commentController.text,
                                'userId':FirebaseAuth.instance.currentUser!.uid,
                                'username': widget.post.username,
                                'time':DateTime.now().millisecondsSinceEpoch
                              });
                              commentCounter++;
                              await FirebaseFirestore.instance.collection('posts').doc(widget.post.id).update({
                                'comments': commentCounter,
                              });
                              _commentController.text="";
                            }

                        },
                        child: Icon(Icons.send),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height:MediaQuery.of(context).size.height*0.5,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('comments')
                        .where("postId",isEqualTo:widget.post.id).snapshots(),
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
                        return Center(
                            child: Text('No Comments')
                        );
                      }



                      return ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),

                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child:  Text(data['username'],style: TextStyle(fontSize:12,color: Colors.black,fontWeight: FontWeight.bold),),
                              ),
                              Container(
                                child:  Text(timeAgoSinceDate(DateTime.fromMillisecondsSinceEpoch(data['time']).toString()),style: TextStyle(fontSize:12,color: Colors.grey,fontWeight: FontWeight.w300),),
                              ),
                              SizedBox(height: 3,),
                              Container(
                                child:  Text(data['comment'],style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),),
                              ),
                              SizedBox(height: 15,),

                            ],
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ))

          ],
        ),
      ),
    );
  }
}
