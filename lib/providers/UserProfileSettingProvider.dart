import 'package:flutter/cupertino.dart';

class UserProfileSettingProvider extends ChangeNotifier{
  int circularBarShow = 0;
  int updateNameBioSuccess = -1;
  int updateEmailPassSuccess = -1;
  bool passwordObscure = true;
  bool newPasswordObscure = true;

  void passwordVisibleInvisible(bool obscure){
    passwordObscure = obscure;
    notifyListeners();
  }

  void newPasswordVisibleInvisible(bool obscure){
    newPasswordObscure = obscure;
    notifyListeners();
  }

  void updateNameBio(){

  }

  void updateEmailPass(){

  }
}