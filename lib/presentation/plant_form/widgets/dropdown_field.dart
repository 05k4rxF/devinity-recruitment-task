import 'package:devinity_recruitment_task/shared/theme/dimensions.dart';
import 'package:flutter/material.dart';

class DropdownItem<T> {
  final T data;
  final String title;
  const DropdownItem({required this.data, required this.title});
}

class DropdownField<T> extends StatefulWidget {
  const DropdownField({
    required this.items,
    required this.onSelect,
    required this.initialValue,
    this.borderColor,
    Key? key,
  }) : super(key: key);

  final T initialValue;
  final List<DropdownItem<T>> items;
  final Function(T) onSelect;
  final Color? borderColor;

  @override
  State<DropdownField> createState() => _DropdownFieldState<T>();
}

class _DropdownFieldState<T> extends State<DropdownField<T>> {
  late T _dropdownValue;

  @override
  void initState() {
    super.initState();
    _dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(canvasColor: Colors.white),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dim.d18,
          vertical: Dim.d2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dim.d8),
          border: Border.all(
            color: widget.borderColor ?? Colors.white,
            width: Dim.d1,
          ),
        ),
        child: DropdownButton<T>(
          value: _dropdownValue,
          isExpanded: true,
          onChanged: (newValue) {
            if (newValue == null) return;
            _onChanged(newValue);
          },
          underline: const SizedBox(),
          items: widget.items.map((item) {
            return DropdownMenuItem(
              value: item.data,
              child: Text(item.title),
              onTap: () => _onChanged(item.data),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _onChanged(T item) {
    setState(() {
      _dropdownValue = item;
    });
    widget.onSelect(item);
  }
}
