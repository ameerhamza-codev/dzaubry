import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;

@immutable
class AuthUser {
  final String UID;
  AuthUser(this.UID);

  factory AuthUser.fromFirebase(User user) => AuthUser(user.uid);
}