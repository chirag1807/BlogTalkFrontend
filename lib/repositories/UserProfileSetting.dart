import 'dart:convert';
import 'dart:developer';
import '../screens/user_reg_login/login_screen.dart';
import '../utils/constants.dart';
import '../utils/prefs.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../config.dart';
import 'UserRegLogin.dart';

class UserProfileSetting{
  Future<int?> updateNameBio(String name, String bio) async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.patch(
          Uri.parse("$baseUrl/user"),
          headers: {"Authorization": "Bearer $accessToken", 'Content-Type': 'application/json; charset=UTF-8',},
          body: json.encode(
              {
                "name": name,
                "bio": bio,
              }
          )
      );

      if(response.statusCode == 200){
        log(response.body);
        return 1;
      }
      else if(response.statusCode == 401){
        int? a = await UserRegLogin().resetToken();
        if(a != 1){
          Get.offAll(() => const LoginScreen(indicator: 0,));
        }
        else{
          return 0;
        }
      }
      else{
        return 0;
      }
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }

  Future<int?> updateEmailBio(String emailId, String oldPass, String newPass) async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.patch(
          Uri.parse("$baseUrl/user/emailPass"),
          headers: {"Authorization": "Bearer $accessToken", 'Content-Type': 'application/json; charset=UTF-8',},
          body: json.encode(
              {
                "email": emailId,
                "oldPass": oldPass,
                "newPass": newPass
              }
          )
      );

      if(response.statusCode == 200){
        log(response.body);
        return 1;
      }
      else if(response.statusCode == 401){
        int? a = await UserRegLogin().resetToken();
        if(a != 1){
          Get.offAll(() => const LoginScreen(indicator: 0,));
        }
        else{
          return 0;
        }
      }
      else if(response.statusCode == 403){
        return 2;
        //Email doesn't exist or Password doesn't match
      }
      else if(response.statusCode == 500){
        return 3;
        //Password Can't be Encrypted
      }
      else{
        return 0;
      }
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }
}