import 'dart:convert';

import 'package:blogtalk/models/ListAndMap.dart';
import 'package:blogtalk/repositories/UserRegLogin.dart';
import 'package:blogtalk/screens/user_reg_login/login_screen.dart';
import 'package:blogtalk/utils/constants.dart';
import 'package:blogtalk/utils/prefs.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SplashScreenProvider extends ChangeNotifier{
  Future<int> checkLoginAndTopic() async {
    bool? isLoggedIn = Prefs.getInstance().getBool(IS_LOGGEDIN);
    bool? isSignedUp = Prefs.getInstance().getBool(IS_SIGNED_UP);
    bool? isTopicSelected = Prefs.getInstance().getBool(IS_TOPIC_SELECTED);


      if(isLoggedIn == true){

        // UserRegLogin userRegLogin = UserRegLogin();
        // int? a = await userRegLogin.resetToken();

        int a = 1;
        //remove above a in production, uncomment line no 15 and 16

        if(a == 1){
          if(isTopicSelected == true){
            ListAndMap? topicNameIds = await UserRegLogin().getAllTopicNameId();
            if(topicNameIds != null){
              return 1;
              // go to main screen
            }
            else{
              return 401;
            }
          }
          else{
            return 2;
            //go to set topic screen
          }
        }
        else{
          Get.offAll(() => const LoginScreen(indicator: 0));
        }
      }

      else if(isSignedUp == true){
        // UserRegLogin userRegLogin = UserRegLogin();
        // int? a = await userRegLogin.resetToken();

        int a = 1;
        //remove above a in production, uncomment line no 44 and 45

        if(a == 1){
          if(isTopicSelected == true){
            ListAndMap? topicNameIds = await UserRegLogin().getAllTopicNameId();
            if(topicNameIds != null){
              return 1;
              // go to main screen
            }
            else{
              return 401;
            }
          }
          else{
            return 3;
            //go to set topic screen
          }
        }
        else{
          Get.offAll(() => const LoginScreen(indicator: 0));
        }
      }

      return 0;
  }
}