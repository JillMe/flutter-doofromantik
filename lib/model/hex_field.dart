import 'package:hexagon/model/pointy_hexagon.dart';

enum FieldType {
  village,
  forest,
  plain,
  grass,
  river,
  train;
}

const fieldTypeCompatibilites = <FieldType, List<FieldType>>{
  FieldType.village: [
    FieldType.village,
    FieldType.forest,
    FieldType.plain,
    FieldType.grass
  ],
  FieldType.forest: [
    FieldType.village,
    FieldType.forest,
    FieldType.plain,
    FieldType.grass
  ],
  FieldType.plain: [
    FieldType.village,
    FieldType.forest,
    FieldType.plain,
    FieldType.grass
  ],
  FieldType.grass: [
    FieldType.village,
    FieldType.forest,
    FieldType.plain,
    FieldType.grass
  ],
  FieldType.river: [FieldType.river],
  FieldType.train: [FieldType.train]
};

const defaultCounts = {0: 1, 1: 1, 2: 1, 3: 1, 4: 1, 5: 1};

class HexField {
  final Map<int, HexEdge> edges;
  const HexField({required this.edges});

  HexEdge? operator [](PointyHexagonalDirection dir) {
    return edges[dir.index];
  }

  getTypeConnection(PointyHexagonalDirection dir) {
    var edge = this[dir];
    return edge?.relations ?? [];
  }
}

class HexEdge {
  final FieldType type;
  final List<int> relations;
  final int count;

  const HexEdge(
      {required this.type, this.count = 1, this.relations = const []});

  isValidConnection(FieldType otherType) {
    return fieldTypeCompatibilites[type]?.contains(otherType) ?? false;
  }
}
