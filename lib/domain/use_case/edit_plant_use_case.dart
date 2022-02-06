import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/domain/use_case/core/usecase.dart';
import 'package:devinity_recruitment_task/infrastructure/plant_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditPlantUseCase implements RightUseCase<void, EditPlantParams> {
  final PlantRepository _plantRepository;

  const EditPlantUseCase(this._plantRepository);

  @override
  Future<void> call(EditPlantParams plantParams) async {
    await _plantRepository.editPlant(id: plantParams.id, plant: plantParams.plant);
  }
}

class EditPlantParams {
  int id;
  Plant plant;

  EditPlantParams({required this.id, required this.plant});
}
