import 'dart:async';

import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/domain/use_case/core/usecase.dart';
import 'package:devinity_recruitment_task/infrastructure/plant_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllPlantsUseCase implements RightUseCase<List<Plant>, void> {
  final PlantRepository _repository;

  const GetAllPlantsUseCase(this._repository);

  @override
  Future<List<Plant>> call([void noParams]) async {
    final _result = await _repository.getAllPlants();

    return _result.fold(
      (failure) => [],
      (result) => result,
    );
  }
}
