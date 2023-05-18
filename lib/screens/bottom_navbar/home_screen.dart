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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        width: w,
        height: h,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: w * 0.8,
                    padding: const EdgeInsets.only(left: 10.0),
                    child: textFormField(searchBlogCtrl, TextInputType.text, false,
                        "Search Blog", Icon(Icons.search, color: themeColorHint2,), const SizedBox(), false, 1)
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
              )
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
