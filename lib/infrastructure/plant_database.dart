import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/infrastructure/plant_dao.dart';

part 'plant_database.g.dart';

@Database(version: 1, entities: [Plant])
abstract class PlantDatabase extends FloorDatabase {
  PlantDao get plantDao;
}
