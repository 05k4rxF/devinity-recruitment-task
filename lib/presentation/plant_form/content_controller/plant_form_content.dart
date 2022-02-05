import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/domain/plant_type.dart';

class PlantFormContent {
  String name;
  DateTime plantedAt;
  PlantType plantType;

  PlantFormContent(
    this.name,
    this.plantedAt,
    this.plantType,
  );

  Plant toPlantData() {
    return Plant(
      name: name,
      plantedAt: plantedAt.millisecondsSinceEpoch,
      plantType: plantType.getString,
    );
  }
}
