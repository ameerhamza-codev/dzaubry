import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  String userId,firstName,lastName,userName, email,password;


  AppUser(
      this.userId, this.firstName, this.lastName, this.userName, this.email, this.password);

  AppUser.fromMap(Map<String,dynamic> map,String key)
      : userId=key,
        firstName = map['firstName'],
        lastName = map['lastName'],
        userName = map['userName'],
        email = map['email'],
        password = map['password'];



  AppUser.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}