import 'package:devinity_recruitment_task/core/infrastructure/injection/injection.dart';
import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/domain/plant_type.dart';
import 'package:devinity_recruitment_task/presentation/plant_form/content_controller/plant_form_content.dart';
import 'package:devinity_recruitment_task/presentation/plant_form/content_controller/plant_form_content_controller.dart';
import 'package:devinity_recruitment_task/presentation/plant_form/cubit/add_plant_form_cubit.dart';
import 'package:devinity_recruitment_task/presentation/plant_form/cubit/add_plant_form_state.dart';
import 'package:devinity_recruitment_task/presentation/plant_form/widgets/dropdown_field.dart';
import 'package:devinity_recruitment_task/shared/theme/dimensions.dart';
import 'package:devinity_recruitment_task/shared/ui/widgets/loading_spinner.dart';
import 'package:devinity_recruitment_task/shared/ui/snackbar.dart';
import 'package:devinity_recruitment_task/shared/ui/widgets/rounded_button.dart';
import 'package:devinity_recruitment_task/utils/extensions/transform_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class PlantFormPage extends StatelessWidget {
  final Plant? plant;

  const PlantFormPage({this.plant, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Plant>? _plants = ModalRoute.of(context)!.settings.arguments as List<Plant>?;

    return BlocProvider<PlantFormPageCubit>(
      create: (_) => getIt<PlantFormPageCubit>()..init(),
      child: BlocConsumer<PlantFormPageCubit, PlantFormPageState>(
        listenWhen: (previous, current) => current is! Loading || current is! ShowView,
        listener: _listener,
        buildWhen: (previous, current) => current is ShowView || current is Loading,
        builder: (context, state) => _builder(context, state, _plants?.first),
      ),
    );
  }

  Widget _builder(BuildContext context, PlantFormPageState state, Plant? plant) {
    return state.maybeMap(
      loading: (value) => const Center(child: LoadingSpinner()),
      showView: (value) => Scaffold(
        appBar: AppBar(
          title: Text(plant != null ? "Edit Plant Form" : "Add Plant Form"),
        ),
        body: _FormBody(plant: plant),
      ),
      orElse: () => const SizedBox.shrink(),
    );
  }

  void _listener(BuildContext context, PlantFormPageState state) {
    state.mapOrNull(
      plantSuccessfulyAdded: (state) {
        showSnackbar(context, "Plant \"${state.plant.name}\" added");
        Navigator.pushReplacementNamed(context, "/");
      },
      plantSuccessfulyEdited: (state) {
        showSnackbar(context, "Plant \"${state.plant.name}\" edited");
        Navigator.pushReplacementNamed(context, "/");
      },
      presentError: (state) => showSnackbar(context, state.message),
    );
  }
}

class _FormBody extends StatefulWidget {
  const _FormBody({
    this.plant,
    Key? key,
  }) : super(key: key);

  final Plant? plant;

  @override
  State<_FormBody> createState() => _FormBodyState();
}

class _FormBodyState extends State<_FormBody> {
  late PlantFormContentController _contentController;
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<PlantFormPageCubit>();

    _contentController = PlantFormContentController((content) => _onChangeDetails(content, cubit));
    _contentController.updateByPlant(widget.plant);
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
            initialValue: widget.plant?.plantType.getPlantType ?? PlantType.alpines,
          ),
          Spacers.h20,
          const Text("Plant date"),
          Spacers.h10,
          GestureDetector(
            onTap: () => _showDateTimePicker(context),
            child: Text(
              DateFormat('dd-MM-yyyy').format(_date),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Spacers.h20,
          Center(
            child: BlocBuilder<PlantFormPageCubit, PlantFormPageState>(
              buildWhen: (previous, current) => current is ShowView,
              builder: (context, state) {
                return state.maybeMap(
                  showView: (value) => value.isSaving
                      ? const LoadingSpinner()
                      : RoundedButton(
                          title: "Save",
                          onPressed: () => _onSaveTap(context, cubit, widget.plant?.id),
                        ),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownItem<PlantType>> get _getPlantTypes {
    return PlantType.values.map((e) => DropdownItem(data: e, title: e.getString.capitalize)).toList();
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

  void _onSaveTap(BuildContext context, PlantFormPageCubit cubit, int? id) => cubit.addPlantToDB(id);
  void _onChangeDetails(PlantFormContent content, PlantFormPageCubit cubit) => cubit.updatePlantsContent(content);
}
