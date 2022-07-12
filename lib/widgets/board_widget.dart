import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon/model/pointy_hexagon.dart';
import 'package:hexagon/util/const.dart';

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
              HexagonWidget.fromSize(field: e.value, size: hexagonSize),
            ))
        .toList();
    tiles.addAll(board.availablePlaces.map((e) => _buildPositioned(
        e.toPixel(),
        HexagonWidget.fromSize(
          size: hexagonSize,
          onTap: () => onTapAvailable(e),
        ))));
    return tiles;
  }

  Widget _buildPositioned(Point p, Widget child) => Positioned(
        left: p.x - bounds.left.toDouble() - 50,
        top: p.y - bounds.top.toDouble() - 50,
        child: child,
      );
}
