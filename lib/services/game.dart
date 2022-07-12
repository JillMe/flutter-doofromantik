import 'dart:math';

import 'package:hexagon/model/hex_field.dart';
import 'package:hexagon/model/hex_grid.dart';
import 'package:hexagon/util/seed.dart';

import '../model/field_type.dart';
import '../model/pointy_hexagon.dart';

bool compatibleWithNeighbor(
    HexField existing, PointyHexagonalDirection dir, HexField incomingType) {
  final type = incomingType[dir].type;
  return existing[Direction.invert(dir)].isValidConnection(type) ?? true;
}

class Game {
  final PointyHexGrid<HexField> board = PointyHexGrid(compatibleWithNeighbor);
  final List<HexField> cards = [];

  Game();

  factory Game.startWithAllTypes() {
    Game game = Game();
    game.board[const PointyHexagon(q: 0, r: 0, s: 0)] = HexField.fromEdge([
      const HexEdge(type: FieldType.grass),
      const HexEdge(type: FieldType.forest),
      const HexEdge(type: FieldType.village),
      const HexEdge(type: FieldType.plain),
      const HexEdge(type: FieldType.train),
      const HexEdge(type: FieldType.river)
    ]);
    return game;
  }

  factory Game.example() {
    Game game = Game.startWithAllTypes();

    while (game.board.length < 10) {
      game.addValidTile();
    }

    return game;
  }

  factory Game.perfectExample() {
    Game game = Game.startWithAllTypes();

    while (game.board.length < 10) {
      game.addValidTile(perfect: true);
    }

    return game;
  }

  reset() {
    final baseField = board[PointyHexagon.origin];
    board.clear();
    if (baseField != null) {
      board[PointyHexagon.origin] = baseField;
    }
  }

  addValidTile({perfect = false}) {
    PointyHexagonalDirection.values;
    final hex = pickRandom(board.availablePlaces);
    var connections = <PointyHexagonalDirection, HexEdge>{};
    for (var dir in PointyHexagonalDirection.values) {
      var neighbor = board.getNeighbor(hex, dir);
      var edge = neighbor?[PointyHexagonalDirection.invert(dir)];
      if (neighbor != null && edge != null) {
        connections[dir] = HexEdge(type: edge.type);
      }
    }

    var field = HexField.generateFittingTile(connections, perfect);
    board[hex] = field;
  }

  Rectangle boundingRect([size = 50.0]) {
    var bounds = board.bounds;
    return Rectangle(bounds.left * size - size, bounds.top * size - size,
        bounds.width * size + 2 * size, bounds.height * size + 2 * size);
  }
}
