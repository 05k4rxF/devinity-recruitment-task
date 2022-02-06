import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'plant_form_state.freezed.dart';

@freezed
class PlantFormPageState with _$PlantFormPageState {
  const factory PlantFormPageState.loading() = Loading;
  const factory PlantFormPageState.showView({@Default(false) bool isSaving}) = ShowView;
  const factory PlantFormPageState.plantSuccessfulyAdded(Plant plant) = PlantSuccessfulyAdded;
  const factory PlantFormPageState.plantSuccessfulyEdited(Plant plant) = PlantSuccessfulyEdited;
  const factory PlantFormPageState.presentError(String message) = PresentError;
}
