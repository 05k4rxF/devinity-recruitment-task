import 'package:freezed_annotation/freezed_annotation.dart';

enum PlantType {
  @JsonValue('all')
  alpines,
  @JsonValue('apartment')
  aquatic,
  @JsonValue('bulbs')
  bulbs,
  @JsonValue('succulents')
  succulents,
  @JsonValue('carnivorous')
  carnivorous,
  @JsonValue('climbers')
  climbers,
  @JsonValue('ferns')
  ferns,
  @JsonValue('grasses')
  grasses,
  @JsonValue('threes')
  threes,
}

extension GetString on PlantType {
  String get getString {
    switch (this) {
      case PlantType.alpines:
        return "alpines";
      case PlantType.aquatic:
        return "aquatic";
      case PlantType.bulbs:
        return "bulbs";
      case PlantType.succulents:
        return "succulents";
      case PlantType.carnivorous:
        return "carnivorous";
      case PlantType.climbers:
        return "climbers";
      case PlantType.ferns:
        return "ferns";
      case PlantType.grasses:
        return "grasses";
      case PlantType.threes:
        return "threes";
    }
  }
}

extension GetPlantType on String {
  PlantType? get getPlantType {
    switch (this) {
      case "alpines":
        return PlantType.alpines;
      case "aquatic":
        return PlantType.aquatic;
      case "bulbs":
        return PlantType.bulbs;
      case "succulents":
        return PlantType.succulents;
      case "carnivorous":
        return PlantType.carnivorous;
      case "climbers":
        return PlantType.climbers;
      case "ferns":
        return PlantType.ferns;
      case "grasses":
        return PlantType.grasses;
      case "threes":
        return PlantType.threes;
    }
  }
}
