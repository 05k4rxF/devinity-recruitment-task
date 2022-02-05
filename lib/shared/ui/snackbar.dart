import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color(0xff323232),
      content: Text(message),
    ),
  );
}
