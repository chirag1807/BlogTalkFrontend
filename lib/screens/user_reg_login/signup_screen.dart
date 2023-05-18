import 'package:blogtalk/screens/user_reg_login/login_screen.dart';
import 'package:blogtalk/screens/user_reg_login/select_preferred_topics_screen.dart';
import 'package:blogtalk/utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/UserRegLoginProvider.dart';
import '../../utils/widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController bioCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  void dispose(){
    super.dispose();
    nameCtrl.dispose();
    bioCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = getWidth(context);
    double h = getHeight(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserRegLoginProvider())
      ],
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
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
                      flex: 2,
                      child: Container(
                        width: w,
                        decoration: const BoxDecoration(
                          color: themeColorHint,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(100.0))
                        ),
                        padding: const EdgeInsets.all(25.0),
                        alignment: Alignment.bottomLeft,
                        child: text("Create Your Account", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Form(
                        key: _key,
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

                              const SizedBox(height: 30.0,),

                              textFormField(emailCtrl, TextInputType.emailAddress, true, "Email Id",
                                  IconButton(
                                      onPressed: (){},
                                      icon: Image.asset("assets/images/email.png")
                                  ), const SizedBox(), false, 0),

                              const SizedBox(height: 30.0,),

                              Consumer<UserRegLoginProvider>(
                                builder: (context, provider, child){
                                return textFormField(passwordCtrl, TextInputType.visiblePassword, false, "Password",
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

                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          width: w,
                          decoration: const BoxDecoration(
                              color: themeColorHint,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(100.0))
                          ),
                          alignment: Alignment.center,
                          child: Consumer<UserRegLoginProvider>(
                            builder: (context, provider, child){
                              if(provider.successRegLogin == 1){
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  Get.to(() => const SelectTopicsScreen(indicator: 0,));
                                });
                              }
                              if(provider.successRegLogin == 0){
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(displaySnackBar(
                                      "Something went wrong, please try again later", themeColorSnackBarRed));
                                });
                              }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Button(
                                  width: 125,
                                  onTap: (){
                                    provider.registerUser(nameCtrl.text, bioCtrl.text, emailCtrl.text, passwordCtrl.text, 0);
                                  },
                                  child:
                                  provider.circularBarShow == 1 ? const CircularProgressIndicator(color: themeColorWhite,) :
                                  text("SignUp", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                                ),
                                const SizedBox(height: 10,),
                                InkWell(
                                  onTap: (){
                                    Get.to(() => const LoginScreen(indicator: 1));
                                  },
                                    child: text("Login Here!", 13, FontWeight.w400, themeColorWhite, TextDecoration.underline, TextAlign.center)),
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
