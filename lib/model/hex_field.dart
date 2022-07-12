import 'package:hexagon/model/pointy_hexagon.dart';
import 'package:hexagon/util/seed.dart';

import 'field_type.dart';

typedef Direction = PointyHexagonalDirection;

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

  HexField copyWith(Map<Direction, HexEdge> copyData) {
    var newEdges = Map<Direction, HexEdge>.from(edges);
    for (var entry in copyData.entries) {
      newEdges.remove(entry.key);
      newEdges[entry.key] = entry.value;
    }
    return HexField._internal(edges: newEdges);
  }
}

class HexEdge {
  final FieldType type;
  final List<int> relations;
  final int count;

  const HexEdge(
      {required this.type, this.count = 1, this.relations = const []});

  isValidConnection(FieldType otherType) {
    return type.isCompatible(otherType);
  }

  factory HexEdge.compatibleTo(FieldType other) {
    var compatibles = other.getCompatibleTypes();
    var type = FieldType.plain;
    if (compatibles.length == 1) {
      type = compatibles.first;
    } else {
      type = pickRandom(compatibles);
    }
    return HexEdge(type: type);
  }
}
