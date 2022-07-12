import 'package:flutter/material.dart';

enum FieldType {
  village,
  forest,
  plain,
  grass,
  river,
  train;

  Color? color() {
    switch (this) {
      case FieldType.village:
        return Colors.grey;
      case FieldType.forest:
        return Colors.green[900];
      case FieldType.plain:
        return Colors.yellow;
      case FieldType.grass:
        return Colors.green[200];
      case FieldType.river:
        return Colors.blue[700];
      case FieldType.train:
        return Colors.brown;
    }
  }

  bool isCompatible(FieldType other) {
    return _compatibles(this).contains(other);
  }

  List<FieldType> getCompatibleTypes() {
    return _compatibles(this);
  }
}

List<FieldType> _compatibles(FieldType type) {
  switch (type) {
    case FieldType.village:
      return const [
        FieldType.village,
        FieldType.forest,
        FieldType.plain,
        FieldType.grass
      ];
    case FieldType.forest:
      return const [
        FieldType.village,
        FieldType.forest,
        FieldType.plain,
        FieldType.grass
      ];
    case FieldType.plain:
      return const [
        FieldType.village,
        FieldType.forest,
        FieldType.plain,
        FieldType.grass
      ];
    case FieldType.grass:
      return const [
        FieldType.village,
        FieldType.forest,
        FieldType.plain,
        FieldType.grass
      ];
    case FieldType.river:
      return const [FieldType.river];
    case FieldType.train:
      return const [FieldType.train];
  }
}
