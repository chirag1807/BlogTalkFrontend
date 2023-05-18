import 'package:blogtalk/providers/UserProfileSettingProvider.dart';
import 'package:blogtalk/screens/user_profile_setting/edit_email_pass_screen.dart';
import 'package:blogtalk/screens/user_profile_setting/my_profile_screen.dart';
import 'package:blogtalk/screens/user_reg_login/select_preferred_topics_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../utils/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

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
                                  const SizedBox(height: 3.0,),
                                  text("Dhyey Panchal", 20, FontWeight.w600, themeColorWhite, TextDecoration.none, TextAlign.center),
                                  const SizedBox(height: 3.0,),
                                  text("Fullstack Web Developer", 16, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center)
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
                            textFormField(nameCtrl, TextInputType.name, false, "Name",
                                IconButton(
                                  onPressed: (){},
                                  icon: Image.asset("assets/images/username.png"),
                                ), const SizedBox(), false, 0),

                            const SizedBox(height: 30.0,),

                            textFormField(bioCtrl, TextInputType.text, false, "Bio",
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
                                    Get.off(() => const MyProfileScreen());
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
                                        // provider.registerUser("", "", emailCtrl.text, passwordCtrl.text, 1);
                                      },
                                      child:
                                      provider.circularBarShow == 1 ? const CircularProgressIndicator(color: themeColorWhite,) :
                                      text("Update", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                                    ),
                                    const SizedBox(height: 10,),
                                    InkWell(
                                        onTap: (){
                                          Get.to(() => const EditEmailPassScreen());
                                        },
                                        child: text("Edit Email/Password", 14, FontWeight.w400, themeColorWhite, TextDecoration.underline, TextAlign.center)
                                    ),
                                    const SizedBox(height: 12,),
                                    InkWell(
                                        onTap: (){
                                          Get.to(() => const SelectTopicsScreen(indicator: 1));
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
