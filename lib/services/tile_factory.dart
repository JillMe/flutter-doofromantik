import 'package:hexagon/model/pointy_hexagon.dart';

import '../model/field_type.dart';
import '../model/hex_field.dart';
import '../util/seed.dart';

HexField generateRandom() {
  final edges =
      List.generate(6, (index) => HexEdge(type: pickRandom(FieldType.values)));
  return _enforceConstraints(HexField.fromEdge(edges));
}

HexField generateFittingTile(Map<Direction, HexEdge> connections,
    [perfect = false]) {
  var field = generateRandom();
  final edges = connections.map((key, value) => MapEntry(key,
      perfect ? HexEdge(type: value.type) : HexEdge.compatibleTo(value.type)));
  return _enforceConstraints(field.copyWith(edges));
}

const List<Weighted<FieldType>> fieldTypeWeights = [
  Weighted(FieldType.grass, 10),
  Weighted(FieldType.forest, 9),
  Weighted(FieldType.plain, 7),
  Weighted(FieldType.village, 4),
  Weighted(FieldType.river, 1),
  Weighted(FieldType.train, 1),
];

const List<Weighted<FieldType>> restricedFieldTypeWeights = [
  Weighted(FieldType.grass, 10),
  Weighted(FieldType.forest, 9),
  Weighted(FieldType.plain, 7),
  Weighted(FieldType.village, 4),
];

HexField _enforceConstraints(HexField input,
    [Set<PointyHexagonalDirection> blockedDirs = const {}]) {
  HexField field = input.copyWith({});
  field = _enforeRestricedConstraints(field, FieldType.train, blockedDirs);
  field = _enforeRestricedConstraints(field, FieldType.river, blockedDirs);
  return field;
}

HexField _enforeRestricedConstraints(HexField field, FieldType type,
    [Set<PointyHexagonalDirection> blockedDirs = const {}]) {
  var edges = Map<PointyHexagonalDirection, HexEdge>.from(field.edges);
  edges.removeWhere((key, value) => value.type != type);
  if (edges.length == 2 || edges.isEmpty) {
    return field;
  } else if (edges.length == 1) {
    var dirs = PointyHexagonalDirection.values.toSet();
    dirs.removeAll(blockedDirs);
    dirs.removeAll(edges.keys);
    if (dirs.isNotEmpty) {
      edges[pickRandom(dirs)] = HexEdge(type: type);
    } else {
      return field;
    }
  } else {
    var dirs = edges.keys.toSet();
    dirs.removeAll(blockedDirs);
    while (dirs.length > 2) {
      var nextDir = pickRandom(dirs);
      dirs.remove(nextDir);
      edges[nextDir] = HexEdge(type: pickWeighted(restricedFieldTypeWeights));
    }
  }
  return field.copyWith(edges);
}
