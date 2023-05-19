import 'package:blogtalk/screens/user_profile_setting/my_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../utils/widgets.dart';

class SavedPostsScreen extends StatefulWidget {
  const SavedPostsScreen({Key? key}) : super(key: key);

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen> {
  @override
  Widget build(BuildContext context) {
    double w = getWidth(context);
    double h = getHeight(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text("Saved Blogs", 20, FontWeight.w700, themeColorWhite, TextDecoration.none, TextAlign.center),
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: appBodyGradient(),
              border: const Border(
                  bottom: BorderSide(
                      color: themeColorWhite,
                      width: 2.0
                  )
              )
          ),
        ),
      ),
      body: Container(
        width: w,
        height: h,
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
