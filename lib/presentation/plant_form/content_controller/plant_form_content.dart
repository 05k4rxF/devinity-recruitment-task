import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/domain/plant_type.dart';

class PlantFormContent {
  String? name;
  DateTime? plantedAt;
  PlantType? plantType;

  PlantFormContent(
    this.name,
    this.plantedAt,
    this.plantType,
  );

  Plant? toPlantData() {
    final name = this.name;
    final plantedAt = this.plantedAt;
    final plantType = this.plantType;

    if (name != null && plantedAt != null && plantType != null) {
      return Plant(
        name: name,
        plantedAt: plantedAt.millisecondsSinceEpoch,
        plantType: plantType.getString,
      );
    }
    return null;
  }
}
