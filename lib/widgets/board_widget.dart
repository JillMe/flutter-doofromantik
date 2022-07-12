import 'dart:math';

import 'package:flutter/material.dart';

import '../model/hex_field.dart';
import '../model/hex_grid.dart';
import 'hexagon_widget.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({
    Key? key,
    required this.board,
    required this.bounds,
  }) : super(key: key);

  final PointyHexGrid<HexField> board;
  final Rectangle bounds;

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
        children: board.entries.map((e) {
          final p = e.key.toPixel(50);
          return Positioned(
            left: p.x - bounds.left.toDouble() - 50,
            top: p.y - bounds.top.toDouble() - 50,
            child: HexagonWidget.fromSize(
              field: e.value,
              size: 50,
            ),
          );
        }).toList(),
      ),
    );
  }
}
