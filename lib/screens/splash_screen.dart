import 'dart:async';

import 'package:blogtalk/providers/SplashScreenProvider.dart';
import 'package:blogtalk/screens/blog_posts/create_blog_screen.dart';
import 'package:blogtalk/screens/user_reg_login/login_screen.dart';
import 'package:blogtalk/screens/user_reg_login/select_preferred_topics_screen.dart';
import 'package:get/get.dart';
import 'package:blogtalk/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashScreenProvider())
      ],
      child: Scaffold(
        body: SafeArea(
          child: Consumer<SplashScreenProvider>(
            builder: (context, provider, child){
              void abc() async {
                int a = await provider.checkLoginAndTopic();
                if(a == 1){
                  Timer(const Duration(seconds: 1), () {
                    // go to home screen here
                    Timer(const Duration(seconds: 1), () {
                      // Get.offAll(() => const BottomNavBarScreen());
                      // Get.offAll(() => const MyProfileScreen());
                      Get.offAll(() => const CreateBlogScreen());
                    });
                  });
                }
                else if(a == 2){
                  //2 means update fav topics
                  Timer(const Duration(seconds: 1), () {
                    Get.offAll(() => const SelectTopicsScreen(indicator:  1,));
                  });
                }
                else if(a == 3){
                  //3 means set fav topics
                  Timer(const Duration(seconds: 1), () {
                    Get.offAll(() => const SelectTopicsScreen(indicator: 0,));
                  });
                }
                else if(a == 401){
                    ScaffoldMessenger.of(context).showSnackBar(displaySnackBar(errorMsg, themeColorSnackBarRed));
                }
                else{
                  Timer(const Duration(seconds: 1), () {
                    Get.offAll(() => const LoginScreen(indicator: 1));
                  });
                }
              }
              // abc();
              void abc1() {
                Timer(const Duration(seconds: 1), () {
                  Get.offAll(() => const CreateBlogScreen());
                });
              }
              abc1();
            return Container(
              width: getWidth(context),
              height: getHeight(context),
              color: themeColorWhite,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: getWidth(context) * 0.15,
                      height: getHeight(context) * 0.30,
                      child: Image.asset("assets/images/blog-talk-logo.png")),
                    const SizedBox(width: 15,),
                    const Text("BlogTalk", style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
              ),
            );
            }
          ),
        ),
      ),
    );
  }
}
