import 'package:flutter/cupertino.dart';
import '../models/user_model.dart';

class UserDataProvider extends ChangeNotifier {
  AppUser? userData;
  String? category;

  void setUserData(AppUser user) {
    userData = user;
    notifyListeners();
  }

  void setCategory(String category) {
    this.category = category;
    notifyListeners();
  }
}
