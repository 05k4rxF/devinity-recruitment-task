import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_plant_form_state.freezed.dart';

@freezed
class PlantFormPageState with _$PlantFormPageState {
  const factory PlantFormPageState.loading() = Loading;
  const factory PlantFormPageState.showView() = ShowView;
  const factory PlantFormPageState.presentError({required String message}) = PresentError;
}
