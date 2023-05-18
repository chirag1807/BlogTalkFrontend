import 'package:blogtalk/screens/splash_screen.dart';
import 'package:blogtalk/screens/user_reg_login/forgot_password_screen.dart';
import 'package:blogtalk/screens/user_reg_login/login_screen.dart';
import 'package:blogtalk/screens/user_reg_login/new_password_screen.dart';
import 'package:blogtalk/screens/user_reg_login/select_preferred_topics_screen.dart';
import 'package:blogtalk/screens/user_reg_login/signup_screen.dart';
import 'package:blogtalk/screens/user_reg_login/verify_code_screen.dart';
import 'package:blogtalk/utils/constants.dart';
import 'package:blogtalk/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.createInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
