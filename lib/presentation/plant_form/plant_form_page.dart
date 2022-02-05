import 'package:devinity_recruitment_task/core/infrastructure/injection/injection.dart';
import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/domain/plant_type.dart';
import 'package:devinity_recruitment_task/presentation/plant_form/content_controller/plant_form_content.dart';
import 'package:devinity_recruitment_task/presentation/plant_form/content_controller/plant_form_content_controller.dart';
import 'package:devinity_recruitment_task/presentation/plant_form/cubit/add_plant_form_cubit.dart';
import 'package:devinity_recruitment_task/presentation/plant_form/widgets/dropdown_field.dart';
import 'package:devinity_recruitment_task/shared/dimensions.dart';
import 'package:devinity_recruitment_task/shared/transform_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class PlantFormPage extends StatelessWidget {
  const PlantFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlantFormPageCubit>(
      create: (_) => getIt<PlantFormPageCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Plant Form"),
        ),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late PlantFormContentController _contentController;
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<PlantFormPageCubit>();

    _contentController = PlantFormContentController((content) => _onChangeDetails(content, cubit));
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlantFormPageCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dim.d30, vertical: Dim.d30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Plant name"),
          TextField(
            controller: _contentController.name,
          ),
          Spacers.h20,
          const Text("Plant type"),
          DropdownField<PlantType>(
            items: _getPlantTypes,
            onSelect: (plantType) => _contentController.update(plantType: plantType),
            initialValue: PlantType.alpines,
          ),
          Spacers.h20,
          const Text("Plant date"),
          Spacers.h10,
          GestureDetector(
            onTap: () => _showDateTimePicker(context),
            child: Text(
              DateFormat('yyyy-MM-dd').format(_date),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Spacers.h20,
          Center(
            child: ElevatedButton(
              onPressed: () => _onSaveTap(context, cubit),
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownItem<PlantType>> get _getPlantTypes {
    return PlantType.values.map((e) => DropdownItem(data: e, title: e.getString.capitalize())).toList();
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
      _contentController.update(plantedAt: date);
    });
  }

  void _onSaveTap(BuildContext context, PlantFormPageCubit cubit) {
    cubit.addPlantToDB(_contentController.prepareContent);
  }

  void _onChangeDetails(PlantFormContent content, PlantFormPageCubit cubit) => cubit.updatePlantsContent(content);
}
