import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/domain/plant_type.dart';
import 'package:devinity_recruitment_task/presentation/plant_form/content_controller/plant_form_content.dart';
import 'package:flutter/cupertino.dart';

class PlantFormContentController {
  final TextEditingController name = TextEditingController();
  DateTime plantedAt = DateTime.now();
  PlantType plantType = PlantType.alpines;

  Function(PlantFormContent) listener;

  PlantFormContentController(this.listener) {
    name.addListener(_listener);
  }

  void update({
    String? name,
    DateTime? plantedAt,
    PlantType? plantType,
  }) {
    this.name.text = name ?? this.name.text;
    this.plantedAt = plantedAt ?? this.plantedAt;
    this.plantType = plantType ?? this.plantType;
    listener(prepareContent);
  }

  void updateByPlant(Plant? plant) {
    if (plant == null) return;

    name.text = plant.name;
    plantedAt = plant.getPlantedTime;
    plantType = plant.plantType.getPlantType!;
  }

  PlantFormContent get prepareContent => PlantFormContent(
        name.text,
        plantedAt,
        plantType,
      );

  void _listener() => listener(prepareContent);

  void dispose() {
    name.removeListener(_listener);

    name.dispose();
  }
}
