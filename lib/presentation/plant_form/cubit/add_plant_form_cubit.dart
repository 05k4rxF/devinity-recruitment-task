import 'package:bloc/bloc.dart';
import 'package:devinity_recruitment_task/domain/plant_service.dart';
import 'package:devinity_recruitment_task/presentation/plant_form/content_controller/plant_form_content.dart';
import 'package:injectable/injectable.dart';

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
    emit(const ShowView(isSaving: true));
    if (_plantFormContent?.name == null || _plantFormContent?.name == "") {
      emit(const PresentError("Fields can't be empty"));
    } else {
      if (_plantFormContent != null) {
        final _plant = _plantFormContent!.toPlantData();
        try {
          // if (_plant != null) {
          //   await _plantService.insertPlant(_plant);
          // }
          emit(PlantSuccessfulyAdded(_plant));
        } catch (e) {
          emit(PresentError(e.toString()));
        }
      } else {
        return;
      }
    }
    emit(const ShowView());
  }

  void updatePlantsContent(PlantFormContent content) => _plantFormContent = content;
}
