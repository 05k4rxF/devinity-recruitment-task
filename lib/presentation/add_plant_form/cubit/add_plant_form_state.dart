import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_plant_form_state.freezed.dart';

@freezed
class AddPlantFormState with _$AddPlantFormState {
  const factory AddPlantFormState.loading() = Loading;
  const factory AddPlantFormState.showView() = ShowView;
  const factory AddPlantFormState.presentError({required String message}) = PresentError;
}
