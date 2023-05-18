import 'package:blogtalk/screens/bottom_navbar/bottom_navbar_screen.dart';
import 'package:blogtalk/screens/user_profile_setting/my_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../providers/UserProfileSettingProvider.dart';
import '../../utils/constants.dart';
import '../../utils/widgets.dart';

class EditEmailPassScreen extends StatefulWidget {
  const EditEmailPassScreen({Key? key}) : super(key: key);

  @override
  State<EditEmailPassScreen> createState() => _EditEmailPassScreenState();
}

class _EditEmailPassScreenState extends State<EditEmailPassScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController currentPasswordCtrl = TextEditingController();
  TextEditingController newPasswordCtrl = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    emailCtrl.dispose();
    currentPasswordCtrl.dispose();
    newPasswordCtrl.dispose();
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
          body: SingleChildScrollView(
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
                      alignment: Alignment.bottomLeft,
                      child: text("Login to Your Account", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: w,
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textFormField(emailCtrl, TextInputType.emailAddress, true, "Email Id",
                              IconButton(
                                  onPressed: (){},
                                  icon: Image.asset("assets/images/email.png")
                              ), const SizedBox(), false, 0),

                          const SizedBox(height: 30.0,),

                          Consumer<UserProfileSettingProvider>(
                              builder: (context, provider, child){

                                return textFormField(currentPasswordCtrl, TextInputType.visiblePassword, false, "Current Password",
                                    IconButton(
                                        onPressed: (){},
                                        icon: Image.asset("assets/images/password.png")
                                    ), IconButton(
                                      onPressed: (){
                                        if(provider.passwordObscure == false){
                                          provider.passwordVisibleInvisible(true);
                                        }
                                        else{
                                          provider.passwordVisibleInvisible(false);
                                        }
                                      },
                                      icon:
                                      provider.passwordObscure == true ? Image.asset("assets/images/password_visibility.png")
                                          : Image.asset("assets/images/password_invisibility.png"),
                                    ), provider.passwordObscure, 0);
                              }
                          ),

                          const SizedBox(height: 30.0,),

                          Consumer<UserProfileSettingProvider>(
                              builder: (context, provider, child){

                                return textFormField(newPasswordCtrl, TextInputType.visiblePassword, false, "New Password",
                                    IconButton(
                                        onPressed: (){},
                                        icon: Image.asset("assets/images/password.png")
                                    ), IconButton(
                                      onPressed: (){
                                        if(provider.newPasswordObscure == false){
                                          provider.newPasswordVisibleInvisible(true);
                                        }
                                        else{
                                          provider.newPasswordVisibleInvisible(false);
                                        }
                                      },
                                      icon:
                                      provider.newPasswordObscure == true ? Image.asset("assets/images/password_visibility.png")
                                          : Image.asset("assets/images/password_invisibility.png"),
                                    ), provider.newPasswordObscure, 0);
                              }
                          ),

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
                              if(provider.updateEmailPassSuccess == 1){
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  Get.offAll(() => const BottomNavBarScreen());
                                });
                              }
                              if(provider.updateEmailPassSuccess == 0){
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
                                    text("Submit", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
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
    );
  }
}
