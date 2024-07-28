import 'package:aiquaboost/constants.dart';
import 'package:flutter/material.dart';

Widget getWelcomeTitle({required String title}) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.only(left: 30),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: welcomeTitleBlue,
      ),
    ),
  );
}

Widget appBarTitle({required String title}) {
  return Text(
    title,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 28,
      fontWeight: FontWeight.w300,
    ),
  );
}
