import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/UserRegLoginProvider.dart';
import '../../utils/constants.dart';
import '../../utils/widgets.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {

  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  void dispose(){
    super.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
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
                      child: text("New Password", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
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
                            Consumer<UserRegLoginProvider>(
                              builder: (context, provider, child){
                              return textFormField(passwordCtrl, TextInputType.visiblePassword, false, "New Password",
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

                            Consumer<UserRegLoginProvider>(
                              builder: (context, provider, child){
                              return textFormField(confirmPasswordCtrl, TextInputType.visiblePassword, false, "Confirm Password",
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
                        child: Consumer<UserRegLoginProvider>(
                          builder: (context, provider, child){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Button(
                                width: 125,
                                onTap: (){

                                },
                                child: text("Submit", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                              ),
                            ],
                          );
                          }
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
