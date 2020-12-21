import 'package:flutter/material.dart';
import 'package:flutter_test_project/Utilities/AppConstants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils{
  static getTextFieldDecoration(BuildContext context, String hintText){
    return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
      hintText: hintText,
      enabled: true,
      enabledBorder: getBorderDecoration(),
      focusedBorder: getBorderDecoration(),
      disabledBorder: getBorderDecoration(),
      focusedErrorBorder: getBorderDecoration(),
      filled: true,
      fillColor: Transparent,
      );
  }

  static getBorderDecoration(){
    return OutlineInputBorder(
    borderSide: BorderSide(
      style: BorderStyle.none,
    ),
    borderRadius: BorderRadius.circular(TEXTFIELD_BORDER_RADUIS),
  );
  }

  static getScreenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static getScreenHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static bool isNotEmptyText(String text){
    return text != null && text != "";
  }

  static bool isValidPhoneNumber(String phoneNumber){
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    return regExp.hasMatch(phoneNumber); 
  }

  static isArabicText(String text) {
    RegExp exp = new RegExp(r"([#][^\s#]*)");
    bool result = exp.hasMatch(text);
    return result;
}

  static showToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}