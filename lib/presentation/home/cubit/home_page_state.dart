import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_page_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState.loading() = Loading;
  const factory HomePageState.showView({
    required List<Plant> plants,
    required int avaliableResults,
    required bool isSearching,
  }) = ShowView;
  const factory HomePageState.presentError({required String message}) = PresentError;
}
