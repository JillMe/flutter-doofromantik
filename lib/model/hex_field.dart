import 'package:hexagon/model/pointy_hexagon.dart';

import 'hex_grid.dart';

typedef Direction = PointyHexagonalDirection;

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
  final Map<Direction, HexEdge> edges;
  const HexField._internal({required this.edges});

  HexEdge operator [](Direction dir) {
    return edges[dir]!;
  }

  getTypeConnection(Direction dir) {
    var edge = this[dir];
    return edge.relations;
  }

  factory HexField.fromEdges(HexEdge edge0, HexEdge edge1, HexEdge edge2,
      HexEdge edge3, HexEdge edge4, HexEdge edge5) {
    final temp = [edge0, edge1, edge2, edge3, edge4, edge5];
    final edges =
        Direction.values.fold<Map<Direction, HexEdge>>({}, (value, element) {
      value[element] = temp[element.index];
      return value;
    });
    return HexField._internal(edges: edges);
  }

  factory HexField.fromEdge(List<HexEdge> inc) {
    var edges = inc.take(6).toList();
    if (edges.length < 6) {
      var filler =
          edges.isEmpty ? const HexEdge(type: FieldType.plain) : edges.first;
      edges =
          List.generate(6, (index) => index < inc.length ? inc[index] : filler);
    }
    return HexField.fromEdges(
        edges[0], edges[1], edges[2], edges[3], edges[4], edges[5]);
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

class HexFieldGrid extends PointyHexGrid<HexField> {
  @override
  bool compatibleWithNeighbor(PointyHexagon existing,
      PointyHexagonalDirection dir, HexField incomingType) {
    final type = incomingType[dir].type;
    final field = this[existing];
    return field?[Direction.invert(dir)].isValidConnection(type) ?? true;
  }
}