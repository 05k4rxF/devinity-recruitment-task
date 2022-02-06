import 'package:devinity_recruitment_task/core/errors/failure.dart';
import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/infrastructure/plant_dao.dart';
import 'package:devinity_recruitment_task/infrastructure/plant_database.dart';
import 'package:injectable/injectable.dart';

abstract class PlantRepository {
  Future<Either<Failure, PlantDao>> initializeDatabase();
  Future<Either<Failure, List<Plant>>> findByName(String searchText);
  Future<Either<Failure, List<Plant>>> getAllPlants();
  Future<Either<Failure, void>> insertPlant(Plant plant);
  Future<Either<Failure, void>> editPlant({required int id, required Plant plant});
}

@Injectable(as: PlantRepository)
class PlantRepositoryImpl implements PlantRepository {
  late PlantDatabase database;
  late PlantDao plantDao;

  PlantRepositoryImpl();

  @override
  Future<Either<Failure, PlantDao>> initializeDatabase() async {
    try {
      database = await $FloorPlantDatabase.databaseBuilder('app_database.db').build();
      plantDao = database.plantDao;
      return Right(plantDao);
    } on Exception catch (_) {
      return const Left(Failure.localDataSourceFailure());
    }
  }

  @override
  Future<Either<Failure, List<Plant>>> findByName(String searchText) async {
    try {
      final _result = await plantDao.findPlantsByName("%$searchText%");
      return Right(_result);
    } on Exception catch (_) {
      return const Left(Failure.localDataSourceFailure());
    }
  }

  @override
  Future<Either<Failure, List<Plant>>> getAllPlants() async {
    try {
      final _result = await plantDao.findAllPlants();
      return Right(_result);
    } on Exception catch (_) {
      return const Left(Failure.localDataSourceFailure());
    }
  }

  @override
  Future<Either<Failure, void>> insertPlant(Plant plant) async {
    try {
      final _result = await plantDao.insertPlant(plant);
      return Right(_result);
    } on Exception catch (_) {
      return const Left(Failure.localDataSourceFailure());
    }
  }

  @override
  Future<Either<Failure, void>> editPlant({required int id, required Plant plant}) async {
    try {
      await plantDao.deletePlant(id);
      final _result = await plantDao.insertPlant(plant);
      return Right(_result);
    } on Exception catch (_) {
      return const Left(Failure.localDataSourceFailure());
    }
  }
}
