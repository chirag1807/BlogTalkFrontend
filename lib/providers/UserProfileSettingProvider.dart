import 'package:blogtalk/repositories/UserProfileSetting.dart';
import 'package:flutter/cupertino.dart';

import '../models/FollowersModel.dart';
import '../models/FollowingsModel.dart';
import '../repositories/followerFollowings.dart';

class UserProfileSettingProvider extends ChangeNotifier{
  int circularBarShow = 0;
  int updateNameBioSuccess = -1;
  int updateEmailPassSuccess = -1;
  bool passwordObscure = true;
  bool newPasswordObscure = true;
  List<FollowersModel>? followers;
  List<FollowingsModel>? followings;
  int successFetchFollowersFollowings = -1;
  int circularBarFollowerFollowingShow = 1;

  void passwordVisibleInvisible(bool obscure){
    passwordObscure = obscure;
    notifyListeners();
  }

  void newPasswordVisibleInvisible(bool obscure){
    newPasswordObscure = obscure;
    notifyListeners();
  }

  void updateNameBio(String name, String bio) async {
    circularBarShow = 1;
    updateNameBioSuccess = -1;
    notifyListeners();

    int? a = await UserProfileSetting().updateNameBio(name, bio);
    if(a == 1){
      circularBarShow = 0;
      updateNameBioSuccess = 1;
      notifyListeners();
    }
    else{
      circularBarShow = 0;
      updateNameBioSuccess = 0;
      notifyListeners();
    }
  }

  void updateEmailPass(String emailId, String oldPass, String newPass) async {
    circularBarShow = 1;
    updateEmailPassSuccess = -1;
    notifyListeners();

    int? a = await UserProfileSetting().updateEmailBio(emailId, oldPass, newPass);

    if(a == 1){
      circularBarShow = 0;
      updateEmailPassSuccess = 1;
      notifyListeners();
    }
    else if(a == 2){
      circularBarShow = 0;
      updateEmailPassSuccess = 2;
      notifyListeners();
    }
    else if(a == 3){
      circularBarShow = 0;
      updateEmailPassSuccess = 3;
      notifyListeners();
    }
    else{
      circularBarShow = 0;
      updateEmailPassSuccess = 0;
      notifyListeners();
    }
  }

  void fetchFollowers() async {
    followers = await FollowerFollowings().fetchFollowers();

    if(followers == null){
      successFetchFollowersFollowings = 0;
      circularBarFollowerFollowingShow = 0;
      notifyListeners();
    }
    else if(followers!.isEmpty){
      successFetchFollowersFollowings = 2;
      circularBarFollowerFollowingShow = 0;
      notifyListeners();
    }
    else{
      successFetchFollowersFollowings = 1;
      circularBarFollowerFollowingShow = 0;
      notifyListeners();
    }
  }

  void fetchFollowings() async {
    followings = await FollowerFollowings().fetchFollowings();

    if(followings == null){
      successFetchFollowersFollowings = 0;
      circularBarFollowerFollowingShow = 0;
      notifyListeners();
    }
    else if(followings!.isEmpty){
      successFetchFollowersFollowings = 2;
      circularBarFollowerFollowingShow = 0;
      notifyListeners();
    }
    else{
      successFetchFollowersFollowings = 1;
      circularBarFollowerFollowingShow = 0;
      notifyListeners();
    }
  }
}