import 'package:blogtalk/providers/UserRegLoginProvider.dart';
import 'package:blogtalk/screens/user_reg_login/login_screen.dart';
import 'package:blogtalk/screens/user_reg_login/verify_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../utils/widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailCtrl = TextEditingController();
    final _key = GlobalKey<FormState>();

    double w = getWidth(context);
    double h = getHeight(context);
    return ChangeNotifierProvider(
      create: (context) => UserRegLoginProvider(),
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              width: w,
              height: h,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        themeColorGreen, themeColorBlue
                      ])
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
                      child: text("Forgot Password", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Form(
                      key: _key,
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
                          ],
                        ),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer<UserRegLoginProvider>(
                              builder: (context, provider, child){
                                if(provider.successEmailSend == 1){
                                  Get.to(() => VerifyCodeScreen(id: provider.id));
                                }
                                else if(provider.successEmailSend == 2){
                                  ScaffoldMessenger.of(context).showSnackBar(displaySnackBar(
                                      "Email Id doesn't match to our records..., please enter correct email id.", themeColorSnackBarRed));
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(displaySnackBar(
                                      "Something went wrong, please try again later...", themeColorSnackBarRed));
                                }
                              return Button(
                                width: 125,
                                onTap: (){
                                  if(emailCtrl.text.isEmpty){
                                    ScaffoldMessenger.of(context).showSnackBar(displaySnackBar(
                                        "Please write your email id first", themeColorSnackBarRed));
                                  }
                                  else{
                                    provider.sendEmailForCode(emailCtrl.text);
                                  }
                                },
                                child:
                                provider.circularBarShow == 1 ? const CircularProgressIndicator(color: themeColorWhite,) :
                                text("Send", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                              );
                              }
                            ),
                            const SizedBox(height: 10,),
                            InkWell(
                                onTap: (){
                                  Get.to(() => const LoginScreen(indicator: 1));
                                },
                                child: text("Back to Login!", 13, FontWeight.w400, themeColorWhite, TextDecoration.underline, TextAlign.center)
                            ),
                          ],
                        )
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
