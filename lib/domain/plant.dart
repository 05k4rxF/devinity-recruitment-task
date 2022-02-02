import 'package:floor/floor.dart';

@entity
class Plant {
  @primaryKey
  final int id;
  final String name;
  final String plantType;
  final int plantedAt;

  Plant(this.id, this.name, this.plantType, this.plantedAt);

  DateTime get getPlantedTime => DateTime.fromMillisecondsSinceEpoch(plantedAt);
}
