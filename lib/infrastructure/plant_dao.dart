import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:floor/floor.dart';

@dao
abstract class PlantDao {
  @Query('SELECT * FROM Plant')
  Future<List<Plant>> findAllPlants();

  @Query('SELECT * FROM Plant WHERE name LIKE :name')
  Future<List<Plant>> findPlantsByName(String name);

  @Query('SELECT * FROM Plant WHERE id = :id')
  Stream<Plant?> findPlantById(int id);

  @Query('DELETE FROM Plant WHERE id = :id')
  Future<void> deletePlant(int id);

  @insert
  Future<void> insertPlant(Plant plant);
}
