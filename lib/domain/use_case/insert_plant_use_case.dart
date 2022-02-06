import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/domain/use_case/core/usecase.dart';
import 'package:devinity_recruitment_task/infrastructure/plant_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class InsertPlantUseCase implements RightUseCase<void, Plant> {
  final PlantRepository _plantRepository;

  const InsertPlantUseCase(this._plantRepository);

  @override
  Future<void> call(Plant plant) async {
    await _plantRepository.insertPlant(plant);
  }
}
