import 'package:devinity_recruitment_task/shared/theme/dimensions.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.title,
    required this.onPressed,
    this.radius = Dim.d20,
    Key? key,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        ),
      ),
    );
  }
}
