import 'package:blogtalk/repositories/UserRegLogin.dart';
import 'package:blogtalk/screens/blog_posts/create_blog_screen.dart';
import 'package:blogtalk/screens/user_profile_setting/followers_screen.dart';
import 'package:blogtalk/utils/constants.dart';
import 'package:blogtalk/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../user_profile_setting/my_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchBlogCtrl = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    searchBlogCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = getWidth(context);
    double h = getHeight(context);
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                      width: w * 0.8,
                      height: h * 0.06,
                      child: textFormField(searchBlogCtrl, TextInputType.text, false,
                          "Search Blog", const Icon(Icons.search, color: themeColorHint2,), const SizedBox(), false, 1)
                  ),
                ),
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Get.to(() => const CreateBlogScreen());
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
      ),
    );
  }
}
