import 'package:blogtalk/models/UserData.dart';
import 'package:blogtalk/repositories/UserRegLogin.dart';
import 'package:flutter/material.dart';

class UserProfileScreenProvider extends ChangeNotifier{
  int circularBarShow = 1;
  int successFetchUserData = -1;
  UserData? userData;

  void fetchUserData() async {
    userData = await UserRegLogin().getUser();
    if(userData == null){
      successFetchUserData = 0;
      circularBarShow = 0;
      notifyListeners();
    }
    else{
      successFetchUserData = 1;
      circularBarShow = 0;
      notifyListeners();
    }
  }
}