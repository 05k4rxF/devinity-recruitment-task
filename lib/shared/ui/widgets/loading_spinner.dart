import 'package:devinity_recruitment_task/shared/theme/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  final double radius;

  const LoadingSpinner({this.radius = Dim.d10, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(cupertinoOverrideTheme: const CupertinoThemeData(brightness: Brightness.light)),
      child: CupertinoActivityIndicator(radius: radius),
    );
  }
}
