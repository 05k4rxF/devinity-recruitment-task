import 'package:devinity_recruitment_task/shared/theme/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class DateTimeField extends StatefulWidget {
  const DateTimeField({
    required this.onUpdateDate,
    Key? key,
  }) : super(key: key);

  final Function(DateTime) onUpdateDate;

  @override
  State<DateTimeField> createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDateTimePicker(context),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: Dim.d50,
        padding: const EdgeInsets.symmetric(
          horizontal: Dim.d18,
          vertical: Dim.d2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dim.d8),
          border: Border.all(
            color: Colors.grey,
            width: Dim.d1,
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            DateFormat('dd-MM-yyyy').format(_date),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _showDateTimePicker(BuildContext context) {
    return DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2000, 1, 1),
      maxTime: DateTime.now(),
      onConfirm: _updatePlantationTime,
      currentTime: DateTime.now(),
      locale: LocaleType.pl,
    );
  }

  void _updatePlantationTime(DateTime date) {
    setState(() {
      _date = date;
      widget.onUpdateDate(date);
    });
  }
}
