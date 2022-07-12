import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon/model/hex_field.dart';
import 'package:hexagon/model/pointy_hexagon.dart';

import 'triangle_piece.dart';

typedef Dir = PointyHexagonalDirection;

class HexagonWidget extends StatelessWidget {
  final HexField field;
  final double width;
  final double height;
  final double size;
  const HexagonWidget({
    Key? key,
    required this.field,
    required this.width,
    required this.height,
    required this.size,
  }) : super(key: key);

  factory HexagonWidget.fromSize(
      {Key? key, required HexField field, double size = 20}) {
    return HexagonWidget(
      field: field,
      width: sqrt(3) * size,
      height: 2 * size,
      size: size,
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(children: Dir.values.map<Widget>(_textForDir).toList()),
    );
  }

  Widget _textForDir(Dir dir) {
    return Positioned(
        top: size / 8,
        left: size / 2,
        child: Transform.rotate(
          angle: pi / 2.0 - pi / 3.0 * dir.index.toDouble(),
          alignment: Alignment.bottomCenter,
          child: TriangularHexagonPieceWidget(
            width: size,
            height: width / 2,
            type: field[dir].type,
          ),
        ));
  }
}
