import 'dart:async';

import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/domain/use_case/core/usecase.dart';
import 'package:devinity_recruitment_task/infrastructure/plant_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPlantByNameUseCase implements RightUseCase<List<Plant>, String> {
  final PlantRepository _repository;

  const GetPlantByNameUseCase(this._repository);

  @override
  Future<List<Plant>> call(String searchText) async {
    final _result = await _repository.findByName(searchText);

    return _result.fold(
      (failure) => [],
      (result) => result,
    );
  }
}
