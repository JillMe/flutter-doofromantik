import 'package:hexagon/model/hex_field.dart';

import '../model/pointy_hexagon.dart';

class Game {
  HexFieldGrid grid = HexFieldGrid();
  List<HexField> cards = [];

  Game();

  factory Game.example() {
    Game game = Game();
    game.grid[const PointyHexagon(q: 0, r: 0, s: 0)] = HexField.fromEdge([
      const HexEdge(type: FieldType.grass),
      const HexEdge(type: FieldType.forest),
      const HexEdge(type: FieldType.village),
      const HexEdge(type: FieldType.plain),
      const HexEdge(type: FieldType.train),
      const HexEdge(type: FieldType.river)
    ]);
    game.grid[const PointyHexagon.fromAxial(q: 1, r: 0)] = HexField.fromEdge([
      const HexEdge(type: FieldType.grass),
    ]);
    game.grid[const PointyHexagon.fromAxial(q: 2, r: 0)] = HexField.fromEdge([
      const HexEdge(type: FieldType.grass),
    ]);
    game.grid[const PointyHexagon.fromAxial(q: 0, r: 1)] = HexField.fromEdge([
      const HexEdge(type: FieldType.grass),
      const HexEdge(type: FieldType.grass),
      const HexEdge(type: FieldType.river),
      const HexEdge(type: FieldType.grass),
    ]);
    return game;
  }
}
