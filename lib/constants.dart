import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Color kPrimaryBlueColor = const Color.fromRGBO(2, 62, 138, 1);

const sizedBoxH50 = SizedBox(
  height: 50,
);
const sizedBoxH30 = SizedBox(
  height: 30,
);
const sizedBoxH25 = SizedBox(
  height: 25,
);
const sizedBoxH20 = SizedBox(
  height: 20,
);
const sizedBoxH10 = SizedBox(
  height: 10,
);

const welcomeTitleBlue = TextStyle(
  fontSize: 30,
  color: Color.fromRGBO(2, 62, 138, 1),
  fontWeight: FontWeight.bold,
);

void showToast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: kPrimaryBlueColor,
      fontSize: 16.0);
}
