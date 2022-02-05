import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/shared/theme/dimensions.dart';
import 'package:devinity_recruitment_task/utils/extensions/transform_string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlantListItem extends StatelessWidget {
  const PlantListItem({
    required this.plant,
    Key? key,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onEditPlantTap(context, plant),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dim.d5),
        child: Row(
          children: [
            Expanded(
              child: Text(
                plant.initials,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Spacers.w10,
            Expanded(
              flex: 4,
              child: Text(
                plant.name,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Spacers.w10,
            Expanded(
              flex: 3,
              child: Text(
                plant.plantType.capitalize,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Spacers.w10,
            Expanded(
              flex: 4,
              child: Text(
                DateFormat('dd-MM-yyyy').format(plant.getPlantedTime),
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onEditPlantTap(BuildContext context, Plant plant) {
    Navigator.pushNamed(context, '/plant-form', arguments: [plant]);
  }
}
