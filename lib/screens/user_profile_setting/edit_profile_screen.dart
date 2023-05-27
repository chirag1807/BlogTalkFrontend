import 'dart:async';

import 'package:blogtalk/providers/UserProfileSettingProvider.dart';
import 'package:blogtalk/screens/bottom_navbar/bottom_navbar_screen.dart';
import 'package:blogtalk/screens/user_profile_setting/edit_email_pass_screen.dart';
import 'package:blogtalk/screens/user_profile_setting/my_profile_screen.dart';
import 'package:blogtalk/screens/user_reg_login/select_preferred_topics_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../utils/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String bio;
  final String image;
  const EditProfileScreen({Key? key, required this.name, required this.bio, required this.image}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController bioCtrl = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    nameCtrl.dispose();
    bioCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = getWidth(context);
    double h = getHeight(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProfileSettingProvider()),
      ],
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: themeColorBlue,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: w,
                height: h,
                decoration: BoxDecoration(
                    gradient: appBodyGradient()
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: w,
                        decoration: const BoxDecoration(
                            color: themeColorHint,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(100.0))
                        ),
                        padding: const EdgeInsets.all(25.0),
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text("Edit Profile", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                            Center(
                              child: Column(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        gradient: widget.image == "" ? appBodyGradient() : const LinearGradient(colors: [themeColorWhite, themeColorWhite]),
                                        shape: BoxShape.circle,
                                      ),
                                      child: widget.image == "" ?
                                      text(getFirstCharacters(widget.name ?? ""), 25, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center)
                                      : Image.network(widget.image, fit: BoxFit.cover,),
                                    ),
                                  ),
                                  const SizedBox(height: 3.0,),
                                  text(widget.name, 20, FontWeight.w600, themeColorWhite, TextDecoration.none, TextAlign.center),
                                  const SizedBox(height: 3.0,),
                                  text(widget.bio, 16, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: w,
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textFormField(nameCtrl, TextInputType.name, false, widget.name,
                                IconButton(
                                  onPressed: (){},
                                  icon: Image.asset("assets/images/username.png"),
                                ), const SizedBox(), false, 0),

                            const SizedBox(height: 30.0,),

                            textFormField(bioCtrl, TextInputType.text, false, widget.bio,
                                IconButton(
                                    onPressed: (){},
                                    icon: Image.asset("assets/images/bio.png")
                                ), const SizedBox(), false, 0),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          width: w,
                          decoration: const BoxDecoration(
                              color: themeColorHint,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(100.0))
                          ),
                          alignment: Alignment.center,
                          child: Consumer<UserProfileSettingProvider>(
                              builder: (context, provider, child){
                                if(provider.updateNameBioSuccess == 1){
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(displaySnackBar(
                                        "Name and Bio Updated Successfully", themeColorSnackBarGreen));
                                    Timer(const Duration(seconds: 1), () {
                                      Get.offAll(() => const BottomNavBarScreen());
                                    });
                                  });
                                }
                                if(provider.updateNameBioSuccess == 0){
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(displaySnackBar(
                                        errorMsg, themeColorSnackBarRed));
                                  });
                                }
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Button(
                                      width: 125,
                                      onTap: (){
                                        provider.updateNameBio(nameCtrl.text, bioCtrl.text);
                                      },
                                      child:
                                      provider.circularBarShow == 1 ? const CircularProgressIndicator(color: themeColorWhite,) :
                                      text("Update", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                                    ),
                                    const SizedBox(height: 10,),
                                    InkWell(
                                        onTap: (){
                                          if(provider.circularBarShow != 1){
                                            Get.to(() => const EditEmailPassScreen());
                                          }
                                        },
                                        child: text("Edit Email/Password", 14, FontWeight.w400, themeColorWhite, TextDecoration.underline, TextAlign.center)
                                    ),
                                    const SizedBox(height: 12,),
                                    InkWell(
                                        onTap: (){
                                          if(provider.circularBarShow != 1){
                                            Get.to(() => const SelectTopicsScreen(indicator: 1));
                                          }
                                        },
                                        child: text("Update Preferred Topics", 14, FontWeight.w400, themeColorWhite, TextDecoration.underline, TextAlign.center)
                                    ),
                                  ],
                                );
                              }
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
String getFirstCharacters(String input) {
  List<String> words = input.split(' ');

  if (words.length > 1) {
    return '${words[0][0]}${words[1][0]}';
  } else {
    return words[0][0];
  }
}