import 'package:hexagon/model/hex_field.dart';
import 'package:hexagon/util/seed.dart';

import '../model/pointy_hexagon.dart';

class Game {
  HexFieldGrid grid = HexFieldGrid();
  List<HexField> cards = [];

  Game();

  factory Game.startWithAllTypes() {
    Game game = Game();
    game.grid[const PointyHexagon(q: 0, r: 0, s: 0)] = HexField.fromEdge([
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

    while (game.grid.grid.length < 10) {
      game.addValidTile();
    }

    return game;
  }

  factory Game.perfectExample() {
    Game game = Game.startWithAllTypes();

    while (game.grid.grid.length < 10) {
      game.addValidTile(perfect: true);
    }

    return game;
  }

  addValidTile({perfect = false}) {
    PointyHexagonalDirection.values;
    final hex = pickRandom(grid.availablePlaces);
    var connections = <PointyHexagonalDirection, HexEdge>{};
    for (var dir in PointyHexagonalDirection.values) {
      var neighbor = grid.getNeighbor(hex, dir);
      var edge = neighbor?[PointyHexagonalDirection.invert(dir)];
      if (neighbor != null && edge != null) {
        connections[dir] = HexEdge(type: edge.type);
      }
    }

    var field = HexField.generateFittingTile(connections, perfect);
    grid[hex] = field;
  }
}
