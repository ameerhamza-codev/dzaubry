import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel{
  String id,username,story,title,image,userId,categoryName;
  int time,comments;
  List like,dislike;




  PostModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        username = map['username'],
        categoryName = map['categoryName']??"",
        title = map['title']??"no title",
        story = map['story'],
        image = map['image'],
        time = map['time'],
        comments = map['comments']??0,
        like = map['like']??[],
        dislike = map['dislike']??[],
        userId = map['userId'];



  PostModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}