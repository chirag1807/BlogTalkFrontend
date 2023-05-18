import 'package:flutter/material.dart';

import 'constants.dart';

double getWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}

Widget textFormField(TextEditingController controller, TextInputType textInputType, bool validator,
    String hintText, Widget prefixIcon, Widget suffixIcon, bool obscure,int indicator){
  return TextFormField(
    controller: controller,
    keyboardType: textInputType,
    cursorColor: themeColorWhite,
    textCapitalization: TextCapitalization.words,
    obscureText: obscure,
    style: const TextStyle(
        color: themeColorWhite
    ),
    validator: (value){
      if(validator){
        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value!)) {
          return 'Please Enter a valid email';
        }
        return null;
      }
      return null;
    },
    decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            color: indicator == 0 ? themeColorHint1 : themeColorHint2
        ),
        enabledBorder:
            indicator == 0?
        const UnderlineInputBorder(
            borderSide: BorderSide(
                color: themeColorWhite,
                width: 2.0
            )
        ) :
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: themeColorWhite,
            width: 2
          )
        ),
        focusedBorder:
          indicator == 0?
        const UnderlineInputBorder(
          borderSide: BorderSide(
            color: themeColorWhite,
            width: 2.0,
          ),
        ) :
        OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
                color: themeColorWhite,
                width: 2
            )
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
    ),
  );
}

Widget circularTextFormField(TextEditingController ctrl, TextInputType textInputType, FocusNode focusNode){
  return Container(
    width: 60,
    height: 60,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: themeColorWhite),
    ),
    child: TextFormField(
      controller: ctrl,
      keyboardType: textInputType,
      maxLength: 1,
      focusNode: focusNode,
      style: const TextStyle(
        color: themeColorWhite
      ),
      cursorColor: themeColorWhite,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        border: InputBorder.none,
        counterText: '',
      ),
    ),
  );
}

LinearGradient appBodyGradient(){
  return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        themeColorGreen, themeColorBlue
      ]);
}
Widget text(String text, double fontSize, FontWeight fontWeight, Color color, TextDecoration textDecoration, TextAlign textAlign, ){
  return Text(text, style: TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    decoration: textDecoration,
    decorationThickness: 2.0,
  ),
    textAlign: textAlign,
  );
}

class Button extends StatelessWidget {
  final void Function() onTap;
  final EdgeInsets? margin;
  final Widget? child;
  final double? width;

  const Button(
      {Key? key, required this.onTap, this.child, this.width, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 50,
          width: width,
          margin: margin,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  themeColorGreen, themeColorBlue
                ]),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: child),
    );
  }
}

class DisableButton extends StatelessWidget {
  final EdgeInsets? margin;
  final double? width;
  final String text;

  const DisableButton({Key? key, this.width, this.margin, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 50,
        width: width,
        margin: margin,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: themeColorHint1,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );
  }
}


SnackBar displaySnackBar(String content, Color bg) {
  return SnackBar(
    content: Text(content),
    backgroundColor: bg,
    elevation: 10,
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(5),
  );
}