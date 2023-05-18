import 'dart:convert';
import 'dart:developer';

import 'package:blogtalk/models/ListAndMap.dart';
import 'package:blogtalk/models/TopicNameId.dart';
import 'package:blogtalk/models/UserData.dart';
import 'package:blogtalk/models/UserFavTopics.dart';
import 'package:blogtalk/screens/user_reg_login/login_screen.dart';
import 'package:blogtalk/utils/prefs.dart';
import 'package:get/get.dart';

import '../models/User.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class UserRegLogin{

  Future<User?> registerAndLoginUser(String name, String bio, String email, String password, int indicator) async {
    //indicator = 0 => register, indicator = 1 => Login
    try{
      var response = await http.post(
        indicator == 0 ? Uri.parse("$baseUrl/user") : Uri.parse("$baseUrl/user/login"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body:
        indicator == 0 ? {
          "name": name,
          "bio": bio,
          "emailId": email,
          "password": password
        } : {
          "email": email,
          "password": password
        },
      );

      log(response.body);

      if(response.statusCode == 200){
        var body = jsonDecode(response.body);
        User user = User.fromJson(body);
        print(body['accessToken']);
        await Prefs.getInstance().setString(ACCESS_TOKEN, body['accessToken']);
        await Prefs.getInstance().setString(REFRESH_TOKEN, body['refreshToken']);
        if(indicator == 0){
          await Prefs.getInstance().setBool(IS_SIGNED_UP, true);
        }
        else{
          await Prefs.getInstance().setBool(IS_LOGGEDIN, true);
        }
        await Prefs.getInstance().setBool(IS_TOPIC_SELECTED, false);
        return user;
      }
      else{
        return null;
      }
    } catch(e){
      log(e.toString());
      return null;
    }

  }

  Future<UserData?> getUser() async {
    String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;

    try{
      var response = await http.get(
          Uri.parse("$baseUrl/user"),
          headers: {"Authorization": "Bearer $accessToken",},
      );

      log(response.body);
      if(response.statusCode == 200){
        print("done");
        var body = jsonDecode(response.body);

        var userData = UserData.fromJson(body);

        return userData;
      }
      else if(response.statusCode == 401){
        int? a = await resetToken();
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

    } catch(e){
      log(e.toString());
      return null;
    }
  }

  Future<String?> forgotPassword(String email) async {
    try{
      var response = await http.post(
        Uri.parse("$baseUrl/user/forgot-password"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          "email": email
        }
      );
      var body = jsonDecode(response.body);
      if(response.statusCode == 200){
        return body['result']['_id'];
      }
      else if(response.statusCode == 510){
        return "unauthorized";
        //2 means not existing email
      }
      else{
        return "error";
      }
    } catch(e){
      log(e.toString());
      return "error";
    }
  }

  Future<String?> verifyCode(String id, int code) async {
    try{
      var response = await http.post(
          Uri.parse("$baseUrl/user/verify-code"),
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          body: {
            "_id": id,
            "code": code
          }
      );
      var body = jsonDecode(response.body);
      if(response.statusCode == 200){
        return "Verification done successfully";
      }
      else if(response.statusCode == 401){
        int? a = await resetToken();
        if(a != 1){
          Get.offAll(() => const LoginScreen(indicator: 0,));
        }
        else{
          return body['msg'];
        }
      }
      else{
        return "Something went wrong, please try again later...";
      }
    } catch(e){
      log(e.toString());
      return "Something went wrong, please try again later...";
    }
  }

  Future<ListAndMap?> getAllTopicNameId() async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.get(
        Uri.parse("$baseUrl/topicNameId/all"),
        headers: {"Authorization": "Bearer $accessToken"}
      );

      log(response.body);

      if(response.statusCode == 200){
        print("done");
        var body = jsonDecode(response.body);

        var topicNameIds = TopicNameId.fromJson(body);

        Map<int, String> topicNameId = <int, String>{};
        for(var ele in topicNameIds.result!){
          topicNameId[ele.topicId!] = ele.topicName!;
        }

        List<int>? favTopics = await getUserFavTopics();

        ListAndMap listAndMap = ListAndMap(topicNameId, favTopics ?? []);

        return listAndMap;
      }
      else if(response.statusCode == 401){
        int? a = await resetToken();
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
    } catch(e){
      log(e.toString());
      return null;
    }
  }

  Future<List<int>?> getUserFavTopics() async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.get(
          Uri.parse("$baseUrl/favTopics"),
          headers: {"Authorization": "Bearer $accessToken"}
      );

      log(response.body);

      if(response.statusCode == 200){
        print("done");
        var body = jsonDecode(response.body);

        UserFavTopics userFavTopics = UserFavTopics.fromJson(body);
        if(userFavTopics.result!.isEmpty){
          return [];
        }
        else{
          print(userFavTopics.result![0].favTopics);
          return userFavTopics.result![0].favTopics;
        }

      }
      else if(response.statusCode == 401){
        int? a = await resetToken();
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
    } catch(e){
      log(e.toString());
      return null;
    }
  }

  Future<int?> setUserFavTopics(List<String> favTopics, int indicator) async {
    //0 for set, 1 for update
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;

      String reqBody = json.encode(
        {
          "favTopics": favTopics
        }
      );

      var response ;
      if(indicator == 0){
        response = await http.post(
            Uri.parse("$baseUrl/favTopics"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              "Authorization": "Bearer $accessToken"},
            body: reqBody
        );
      }
      else{
        response = await http.patch(
            Uri.parse("$baseUrl/favTopics"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              "Authorization": "Bearer $accessToken"},
            body: reqBody
        );
      }

      log(response.body);

      if(response.statusCode == 200){
        await Prefs.getInstance().setBool(IS_TOPIC_SELECTED, true);
        return 1;
      }
      else if(response.statusCode == 401){
        int? a = await resetToken();
        if(a != 1){
          Get.offAll(() => const LoginScreen(indicator: 0,));
        }
        else {
          return 0;
        }
      }
      else{
        return 0;
      }
    } catch(e){
      log(e.toString());
      return 0;
    }
  }

  Future<int?> resetToken() async {
    final String? refreshToken = Prefs.getInstance().getString(REFRESH_TOKEN);
    try{
      var response = await http.post(
        Uri.parse("$baseUrl/user/reset-token"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          "refreshToken": refreshToken
        },
      );
      log(response.body);
      var body = jsonDecode(response.body);
      if(response.statusCode == 200){
        await Prefs.getInstance().setString(
          ACCESS_TOKEN,
          body["accessToken"],
        );
        await Prefs.getInstance().setString(
          REFRESH_TOKEN,
          body["refreshToken"],
        );
        return 1;
      }
      else{
        return 0;
      }
    }
    catch(e) {
      log(e.toString());
      return 0;
    }
  }
}