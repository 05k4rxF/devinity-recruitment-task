import 'package:flutter/cupertino.dart';

class Dim {
  static const double d0 = 0;
  static const double d1 = 1;
  static const double d2 = 2;
  static const double d8 = 8;
  static const double d10 = 10;
  static const double d18 = 18;
  static const double d20 = 20;
  static const double d30 = 30;
  static const double d50 = 50;
}

class Spacers {
  static const Widget h10 = SizedBox(height: Dim.d10);
  static const Widget h20 = SizedBox(height: Dim.d20);
  static const Widget h30 = SizedBox(height: Dim.d30);
  static const Widget h50 = SizedBox(height: Dim.d50);

  static const Widget w30 = SizedBox(width: Dim.d30);
  static const Widget w50 = SizedBox(width: Dim.d50);
}
