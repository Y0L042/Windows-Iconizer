import 'package:flutter/material.dart';
import 'package:iconizer/ui_config.dart';

class WidgetFunctions {

  static Widget customCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(text, textAlign: TextAlign.center),
    );
  }

  static Widget customHeader(String title, double width) {
    return SizedBox(
      width: width,
      child: Text(title, textAlign: TextAlign.center),
    );
  }



}