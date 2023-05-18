import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../utils/widgets.dart';
import '../user_profile_setting/my_profile_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    double w = getWidth(context);
    double h = getHeight(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        width: w,
        height: h,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text("Notifications", 20, FontWeight.w700, themeColorWhite, TextDecoration.none, TextAlign.center),
                    SizedBox(
                      width: w * 0.20,
                      child: InkWell(
                          onTap: (){
                            Get.to(() => const MyProfileScreen(), transition: Transition.upToDown);
                          },
                          child: SvgPicture.asset("assets/images/profile_icon.svg")),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5,),
              const Divider(color: themeColorWhite, thickness: 3.0,),
              const SizedBox(height: 5,),
            ],
          ),
        ),
      ),
    );
  }
}
