import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  String userId,firstName,lastName,userName, email,password, profilePic;


  AppUser(
      this.userId, this.firstName, this.lastName, this.userName, this.email, this.password, this.profilePic);

  AppUser.fromMap(Map<String,dynamic> map,String key)
      : userId=key,
        firstName = map['firstName'],
        lastName = map['lastName'],
        userName = map['userName'],
        email = map['email'],
        password = map['password'],
        profilePic = map['profileURL'];




  AppUser.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}