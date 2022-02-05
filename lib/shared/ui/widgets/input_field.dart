import 'package:devinity_recruitment_task/shared/theme/dimensions.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    this.onChanged,
    this.contentController,
    this.hintText,
    this.contentPadding,
    Key? key,
  }) : super(key: key);

  final Function(String)? onChanged;
  final TextEditingController? contentController;
  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged?.call,
      controller: contentController,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        contentPadding: contentPadding ?? const EdgeInsets.only(left: Dim.d20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dim.d8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
