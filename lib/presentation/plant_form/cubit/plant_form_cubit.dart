import 'package:bloc/bloc.dart';
import 'package:devinity_recruitment_task/domain/use_case/edit_plant_use_case.dart';
import 'package:devinity_recruitment_task/domain/use_case/initialize_database_use_case.dart';
import 'package:devinity_recruitment_task/domain/use_case/insert_plant_use_case.dart';
import 'package:devinity_recruitment_task/presentation/plant_form/content_controller/plant_form_content.dart';
import 'package:injectable/injectable.dart';

import 'plant_form_state.dart';

@injectable
class PlantFormPageCubit extends Cubit<PlantFormPageState> {
  final InitializeDatabaseUseCase _initializeDatabaseUseCase;
  final EditPlantUseCase _editPlantUseCase;
  final InsertPlantUseCase _insertPlantUseCase;

  PlantFormContent? _plantFormContent;

  PlantFormPageCubit(
    this._initializeDatabaseUseCase,
    this._editPlantUseCase,
    this._insertPlantUseCase,
  ) : super(const Loading());

  Future<void> init() async {
    await _initializeDatabaseUseCase();

    emit(const ShowView());
  }

  Future<void> addPlantToDB(int? id) async {
    emit(const ShowView(isSaving: true));

    if (_plantFormContent?.name == null || _plantFormContent?.name == "") {
      emit(const PresentError("Fields can't be empty"));
    } else {
      if (_plantFormContent != null) {
        final _plant = _plantFormContent!.toPlantData();

        if (id != null) {
          try {
            await _editPlantUseCase(EditPlantParams(id: id, plant: _plant));
            emit(PlantSuccessfulyEdited(_plant));
          } catch (e) {
            emit(PresentError(e.toString()));
          }
        } else {
          try {
            await _insertPlantUseCase(_plant);
            emit(PlantSuccessfulyAdded(_plant));
          } catch (e) {
            emit(PresentError(e.toString()));
          }
        }
      } else {
        emit(const PresentError("Unexpected null value. Try again"));
      }
    }

    emit(const ShowView());
  }

  void updatePlantsContent(PlantFormContent content) => _plantFormContent = content;
}
