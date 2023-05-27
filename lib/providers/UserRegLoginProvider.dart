import 'package:blogtalk/repositories/UserRegLogin.dart';
import 'package:flutter/cupertino.dart';

import '../models/User.dart';

class UserRegLoginProvider extends ChangeNotifier{
  int circularBarShow = 0;
  int successRegLogin = -1;
  bool passwordObscure = true;
  bool newPasswordObscure = true;
  int successEmailSend = -1;
  int codeVerified = -1;
  String a = "";
  String id = "";
  List<String> userFavTopics = [];
  int setUpdateFavTopicsDone = -1;

  void registerUser(String name, String bio, String email, String password, int indicator) async {
    successRegLogin = -1;
    circularBarShow = 1;
    notifyListeners();
    UserRegLogin userRegLogin = UserRegLogin();
    User? user = await userRegLogin.registerAndLoginUser(name, bio, email, password, indicator);
    if(user != null){
      successRegLogin = 1;
      circularBarShow = 0;
      notifyListeners();
    }
    else{
      successRegLogin = 0;
      circularBarShow = 0;
      notifyListeners();
    }
  }

  void passwordVisibleInvisible(bool obscure){
    passwordObscure = obscure;
    notifyListeners();
  }

  void newPasswordVisibleInvisible(bool obscure){
    newPasswordObscure = obscure;
    notifyListeners();
  }

  void sendEmailForCode(String email) async {
    a = "";
    circularBarShow = 1;
    notifyListeners();
    UserRegLogin userRegLogin = UserRegLogin();
    a = (await userRegLogin.forgotPassword(email))!;
    if(a == "unauthorized"){
      successEmailSend = 2;
      circularBarShow = 0;
      notifyListeners();
    }
    else if(a == "error"){
      successEmailSend = 0;
      circularBarShow = 0;
      notifyListeners();
    }
    else{
      id = a;
      successEmailSend = 1;
      circularBarShow = 0;
      notifyListeners();
    }
  }

  void verifyCode(String id, int code) async {
    a = "";
    circularBarShow = 1;
    notifyListeners();
    UserRegLogin userRegLogin = UserRegLogin();
    a = (await userRegLogin.verifyCode(id, code))!;
    if(a == "Verification done successfully"){
      codeVerified = 1;
      circularBarShow = 0;
      notifyListeners();
    }
    else{
      codeVerified = 0;
      circularBarShow = 0;
      notifyListeners();
    }
  }

  void addRemoveToUserFavTopic(String favTopic, int indicator){
    //indicator = 0 then add else remove
    if(indicator == 0){
      userFavTopics.add(favTopic);
      print(userFavTopics);
      notifyListeners();
    }
    else{
      userFavTopics.remove(favTopic);
      notifyListeners();
    }
  }

  void setUpdateFavTopics(List<String> favTopics, int indicator) async {
    setUpdateFavTopicsDone = -1;
    circularBarShow = 1;
    notifyListeners();
    UserRegLogin userRegLogin = UserRegLogin();
    int? abc = await userRegLogin.setUserFavTopics(favTopics, indicator);
    if(abc == 1){
      setUpdateFavTopicsDone = 1;
      circularBarShow = 0;
      notifyListeners();
    }
    else{
      setUpdateFavTopicsDone = 0;
      circularBarShow = 0;
      notifyListeners();
    }
  }

}