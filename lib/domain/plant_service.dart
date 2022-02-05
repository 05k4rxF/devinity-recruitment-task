import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/infrastructure/plant_dao.dart';
import 'package:devinity_recruitment_task/infrastructure/plant_database.dart';
import 'package:injectable/injectable.dart';

@injectable
class PlantService {
  late PlantDatabase database;
  late PlantDao plantDao;

  PlantService();

  Future<String?> initializeDatabase() async {
    database = await $FloorPlantDatabase.databaseBuilder('app_database.db').build();
    plantDao = database.plantDao;
  }

  Future<List<Plant>> findByName(String searchText) async => plantDao.findPlantsByName("%$searchText%");

  Future<List<Plant>> getAllPlants() async => plantDao.findAllPlants();

  Future<void> insertPlant(Plant plant) async => plantDao.insertPlant(plant);

  Future<void> editPlant({required int id, required Plant plant}) async {
    await plantDao.deletePlant(id);
    await plantDao.insertPlant(plant);
  }
}
