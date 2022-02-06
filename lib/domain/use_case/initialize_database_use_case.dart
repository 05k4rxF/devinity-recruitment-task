import 'package:devinity_recruitment_task/domain/use_case/core/usecase.dart';
import 'package:devinity_recruitment_task/infrastructure/plant_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class InitializeDatabaseUseCase implements RightUseCase<void, void> {
  final PlantRepository _plantRepository;

  const InitializeDatabaseUseCase(this._plantRepository);

  @override
  Future<void> call([void noParams]) async {
    await _plantRepository.initializeDatabase();
  }
}
