import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon/model/pointy_hexagon.dart';
import 'package:hexagon/util/const.dart';
import 'package:hexagon/widgets/triangle_piece.dart';

import '../model/hex_field.dart';
import '../model/hex_grid.dart';
import 'hexagon_widget.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({
    Key? key,
    required this.board,
    required this.bounds,
    required this.onTapAvailable,
  }) : super(key: key);

  final PointyHexGrid<HexField> board;
  final Rectangle bounds;
  final Function(PointyHexagon point) onTapAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: bounds.width.toDouble(),
      height: bounds.height.toDouble(),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Colors.orange, Colors.red],
          stops: <double>[0.0, 1.0],
        ),
      ),
      child: Stack(
        children: buildTiles().toList(),
      ),
    );
  }

  Iterable<Widget> buildTiles() {
    List<Widget> tiles = board.entries
        .map((e) => _buildPositioned(
              e.key.toPixel(),
              HexagonWidget.standard(
                child: oldHexagons(e.value.edges),
              ),
            ))
        .toList();
    tiles.addAll(board.availablePlaces.map((e) => _buildPositioned(
        e.toPixel(),
        HexagonWidget.standard(
          padding: 10.0,
          elevation: 10,
          child: GestureDetector(
            onTap: () => onTapAvailable(e),
            child: Container(
              color: Colors.red,
            ),
          ),
        ))));
    return tiles;
  }

  Widget _buildPositioned(Point p, Widget child) => Positioned(
        left: p.x - bounds.left.toDouble() - 50,
        top: p.y - bounds.top.toDouble() - 50,
        child: child,
      );
}

Widget oldHexagons(Map<Dir, HexEdge> fields) =>
    Stack(children: fields.entries.map(_tileForDir).toList());

Widget _tileForDir(MapEntry<Dir, HexEdge> entry) {
  return Positioned(
      top: hexagonSize / 8,
      left: hexagonSize / 2 - 7,
      child: Transform.rotate(
        angle: pi / 2.0 - pi / 3.0 * entry.key.index.toDouble(),
        alignment: Alignment.bottomCenter,
        child: TriangularHexagonPieceWidget(
          width: hexagonSize,
          height: sqrt(3) * hexagonSize / 2,
          type: entry.value.type,
        ),
      ));
}
