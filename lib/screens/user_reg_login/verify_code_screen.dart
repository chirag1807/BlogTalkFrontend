import 'package:blogtalk/providers/UserRegLoginProvider.dart';
import 'package:blogtalk/screens/user_reg_login/new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../utils/widgets.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String id;
  const VerifyCodeScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {

  TextEditingController ctrl1 = TextEditingController();
  TextEditingController ctrl2 = TextEditingController();
  TextEditingController ctrl3 = TextEditingController();
  TextEditingController ctrl4 = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();

  final _key = GlobalKey<FormState>();

  @override
  void dispose(){
    super.dispose();
    ctrl1.dispose();
    ctrl2.dispose();
    ctrl3.dispose();
    ctrl4.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
  }

  @override
  void initState() {
    super.initState();
    ctrl1.addListener(_onChanged);
    ctrl2.addListener(_onChanged);
    ctrl3.addListener(_onChanged);
    ctrl4.addListener(_onChanged);
  }

  void _onChanged() {
    if (ctrl1.text.length == 1) {
      focusNode2.requestFocus();
    }
    if (ctrl2.text.length == 1) {
      focusNode3.requestFocus();
    }
    if (ctrl3.text.length == 1) {
      focusNode4.requestFocus();
    }
    if(ctrl4.text.length == 1) {
      FocusScope.of(context).unfocus();
    }
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
                      child: text("Verification", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            text("Enter Verification Code", 14, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                            const SizedBox(height: 20.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                circularTextFormField(ctrl1, TextInputType.number, focusNode1),
                                circularTextFormField(ctrl2, TextInputType.number, focusNode2),
                                circularTextFormField(ctrl3, TextInputType.number, focusNode3),
                                circularTextFormField(ctrl4, TextInputType.number, focusNode4),
                              ],
                            ),
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
                            if(provider.codeVerified == 1){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  displaySnackBar("Verification Done Successfully", themeColorSnackBarGreen));
                              Get.to(() => const NewPasswordScreen());
                            }
                            else if(provider.codeVerified == 0){
                              ScaffoldMessenger.of(context).showSnackBar(displaySnackBar(provider.a, themeColorSnackBarRed));
                            }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Button(
                                width: 125,
                                onTap: (){
                                  int code = int.parse(ctrl1.text + ctrl2.text + ctrl3.text + ctrl4.text);
                                  provider.verifyCode(widget.id, code);
                                },
                                child:
                                provider.circularBarShow == 1 ? const CircularProgressIndicator(color: themeColorWhite,) :
                                text("Verify", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                              ),
                              const SizedBox(height: 10,),
                              InkWell(
                                  onTap: (){

                                  },
                                  child: text("Didn't Receive? Resend!", 12, FontWeight.w400, themeColorWhite, TextDecoration.underline, TextAlign.center)
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
