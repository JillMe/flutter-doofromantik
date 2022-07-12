import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon/model/hex_field.dart';
import 'package:hexagon/model/pointy_hexagon.dart';

typedef Dir = PointyHexagonalDirection;

class HexagonWidget extends StatelessWidget {
  final HexField field;
  final double width;
  final double height;
  const HexagonWidget(
      {Key? key,
      required this.field,
      required this.width,
      required this.height})
      : super(key: key);

  factory HexagonWidget.fromSize(
      {Key? key, required HexField field, double size = 20}) {
    return HexagonWidget(
      field: field,
      width: sqrt(3) * size,
      height: 2 * size,
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
          color: Colors.green,
          shape: BeveledRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.elliptical(height, width / 3)))),
      child: Stack(children: Dir.values.map<Widget>(_textForDir).toList()),
    );
  }

  Widget _textForDir(Dir dir) {
    return Positioned(
      top: Dir.isTop(dir)
          ? height / 4
          : Dir.isCenter(dir)
              ? height / 2
              : null,
      bottom: Dir.isBottom(dir) ? height / 4 : null,
      right: Dir.isRight(dir) ? 0 : null,
      left: Dir.isLeft(dir) ? 0 : null,
      child: Transform.rotate(
          angle: pi / 2 - pi / 3 * dir.index,
          child: Text(field[dir].type.name)),
    );
  }
}
