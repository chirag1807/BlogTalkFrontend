import 'package:blogtalk/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/widgets.dart';
import '../user_profile_setting/my_profile_screen.dart';

class YourPostsScreen extends StatefulWidget {
  const YourPostsScreen({Key? key}) : super(key: key);

  @override
  State<YourPostsScreen> createState() => _YourPostsScreenState();
}

class _YourPostsScreenState extends State<YourPostsScreen> {
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
                    text("Your Posts", 20, FontWeight.w700, themeColorWhite, TextDecoration.none, TextAlign.center),
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
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){

          },
          backgroundColor: const Color(0xCCFFFFFF),
          icon: SvgPicture.asset("assets/images/write_blog_icon.svg"),
          label: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) {
              return appBodyGradient().createShader(bounds);
            },
            child: const Text("Write Blog", style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500
            ),),
          )
      ),
    );
  }
}
