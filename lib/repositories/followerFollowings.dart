import 'dart:convert';
import 'dart:developer';
import 'package:blogtalk/models/FollowersModel.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../config.dart';
import '../models/FollowingsModel.dart';
import '../screens/user_reg_login/login_screen.dart';
import '../utils/constants.dart';
import '../utils/prefs.dart';
import 'UserRegLogin.dart';

class FollowerFollowings{
  Future<void> updateFollowerFollowings(String uid, String followingId, String followerId, int indicator) async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.patch(
          Uri.parse("$baseUrl/blogPost/updateLike"),
          headers: {"Authorization": "Bearer $accessToken", 'Content-Type': 'application/json; charset=UTF-8',},
          body: json.encode(
              {
                "uid": uid,
                "followingId": followerId,
                "followerId": followerId,
                "indicator": indicator
              }
          )
      );

      if(response.statusCode == 200){
        log(response.body);
      }
      else if(response.statusCode == 401){
        int? a = await UserRegLogin().resetToken();
        if(a != 1){
          Get.offAll(() => const LoginScreen(indicator: 0,));
        }
        else{
          print(a);
        }
      }

    } catch(e) {
      log(e.toString());
    }
  }

  Future<List<FollowingsModel>?> fetchFollowings() async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.get(
          Uri.parse("$baseUrl/userFollowing"),
          headers: {"Authorization": "Bearer $accessToken"}
      );

      if(response.statusCode == 200){
        print("done");
        var body = jsonDecode(response.body);

        if(body["result"].length == 0){
          return [];
        }
        else{
          List<FollowingsModel> followings = [];
          for(int i = 0; i < body["result"].length; i++){
            followings.add(FollowingsModel.fromJson(body["result"][i]));
          }
          return followings;
        }
      }
      else if(response.statusCode == 401){
        int? a = await UserRegLogin().resetToken();
        if(a != 1){
          Get.offAll(() => const LoginScreen(indicator: 0,));
        }
        else{
          return null;
        }
      }
      else{
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<FollowersModel>?> fetchFollowers() async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.get(
          Uri.parse("$baseUrl/userFollowers"),
          headers: {"Authorization": "Bearer $accessToken"}
      );

      if(response.statusCode == 200){
        print("done");
        var body = jsonDecode(response.body);

        if(body["result"].length == 0){
          return [];
        }
        else{
          List<FollowersModel> followers = [];
          for(int i = 0; i < body["result"].length; i++){
            followers.add(FollowersModel.fromJson(body["result"][i]));
          }
          return followers;
        }
      }
      else if(response.statusCode == 401){
        int? a = await UserRegLogin().resetToken();
        if(a != 1){
          Get.offAll(() => const LoginScreen(indicator: 0,));
        }
        else{
          return null;
        }
      }
      else{
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}