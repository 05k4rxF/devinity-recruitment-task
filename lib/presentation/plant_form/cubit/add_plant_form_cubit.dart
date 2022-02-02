import 'package:bloc/bloc.dart';
import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/domain/plant_service.dart';
import 'package:devinity_recruitment_task/presentation/plant_form/content_controller/plant_form_content.dart';
import 'package:injectable/injectable.dart';
import 'package:devinity_recruitment_task/domain/plant_type.dart';

import 'add_plant_form_state.dart';

@injectable
class PlantFormPageCubit extends Cubit<PlantFormPageState> {
  final PlantService _plantService;

  PlantFormContent? _plantFormContent;

  PlantFormPageCubit(this._plantService) : super(const Loading());

  Future<void> init() async {
    await _plantService.initializeDatabase();

    emit(const ShowView());
  }

  Future<void> addPlantToDB() async {
    final _plant = _plantFormContent?.toPlantData();
    if (_plant != null) {
      await _plantService.insertPlan(_plant);
    }
  }

  void updateDetailsContent(PlantFormContent content) {
    _plantFormContent = content;
  }
}
