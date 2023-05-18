import 'package:blogtalk/providers/BottomNavIndexChangeProvider.dart';
import 'package:blogtalk/screens/user_profile_setting/edit_profile_screen.dart';
import 'package:blogtalk/screens/user_profile_setting/followers_screen.dart';
import 'package:blogtalk/screens/user_profile_setting/following_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../utils/widgets.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  List<String> navItems = [
    "Your Posts",
    "Saved Blogs",
    "Muted"
  ];

  @override
  Widget build(BuildContext context) {
    double w = getWidth(context);
    double h = getHeight(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavIndexChangeProvider()),
      ],
      child: Scaffold(
        backgroundColor: themeColorBlue,
        body: SafeArea(
          child: Container(
            width: w,
            height: h,
            padding: const EdgeInsets.only(top: 15.0),
            decoration: BoxDecoration(
                gradient: appBodyGradient()
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        text("My Profile", 20, FontWeight.w700, themeColorWhite, TextDecoration.none, TextAlign.center),
                        SizedBox(
                          width: w * 0.20,
                          child: InkWell(
                              onTap: (){
                                Get.to(() => const EditProfileScreen(), transition: Transition.upToDown);
                              },
                              child: SvgPicture.asset("assets/images/edit_profile_icon.svg")),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  const Divider(color: themeColorWhite, thickness: 3.0,),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: themeColorBlue,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          child: text("DP", 25, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center),
                        ),
                        const SizedBox(width: 8.0,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text("Dhyey Panchal", 20, FontWeight.w600, themeColorWhite, TextDecoration.none, TextAlign.center),
                            const SizedBox(height: 3.0,),
                            text("Fullstack Web Developer", 16, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center)
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          text("Posts", 17, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center),
                          text("2", 22, FontWeight.w600, themeColorWhite, TextDecoration.none, TextAlign.center),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          Get.to(() => const FollowersScreen(), transition: Transition.leftToRight);
                        },
                        child: Column(
                          children: [
                            text("Followers", 17, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center),
                            text("38", 22, FontWeight.w600, themeColorWhite, TextDecoration.none, TextAlign.center),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Get.to(() => const FollowingScreen(), transition: Transition.leftToRight);
                        },
                        child: Column(
                          children: [
                            text("Followings", 17, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center),
                            text("26", 22, FontWeight.w600, themeColorWhite, TextDecoration.none, TextAlign.center),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Consumer<BottomNavIndexChangeProvider>(
                      builder: (context, provider, child){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for(int i=0 ; i< navItems.length; i++)
                          InkWell(
                              onTap: () {
                                provider.changeIndex(i);
                              },
                            child: text(navItems[i], 17,  provider.myIndex == i ? FontWeight.w500 : FontWeight.w300, themeColorWhite,
                                provider.myIndex == i ? TextDecoration.underline : TextDecoration.none, TextAlign.center),
                          )
                        ],
                      );
                      }
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// ListView.builder(
// shrinkWrap: true,
// scrollDirection: Axis.horizontal,
// itemCount: navItems.length,
// itemBuilder: (context, index){
// return InkWell(
// onTap: (){
// provider.changeIndex(index);
// },

// );
// },
// );