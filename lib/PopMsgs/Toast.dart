import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: non_constant_identifier_names
void ShowToast(String str) {
  Fluttertoast.showToast(
      msg: str,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      fontSize: 11.0);
}
