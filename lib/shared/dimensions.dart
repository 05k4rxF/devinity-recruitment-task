import 'package:flutter/cupertino.dart';

class Dim {
  static const double d0 = 0;
  static const double d30 = 30;
  static const double d50 = 50;
}

class Spacers {
  static const Widget h30 = SizedBox(height: Dim.d30);
  static const Widget h50 = SizedBox(height: Dim.d50);

  static const Widget w30 = SizedBox(width: Dim.d30);
  static const Widget w50 = SizedBox(width: Dim.d50);
}
