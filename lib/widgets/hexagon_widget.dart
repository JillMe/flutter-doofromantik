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
          shape: BeveledRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.elliptical(height, width / 3)))),
      child:
          Stack(children: Dir.values.map<Widget>(_textForDir).toList()),
    );
  }

  Widget _textForDir(Dir dir) {
    return Positioned(
        top: Dir.isTop(dir)
            ? height / 6
            : Dir.isCenter(dir)
                ? height / 3
                : null,
        bottom: Dir.isBottom(dir) ? height / 6 : null,
        right: Dir.isRight(dir)
            ? Dir.isCenter(dir)
                ? 0
                : width / 6
            : null,
        left: Dir.isLeft(dir)
            ? Dir.isCenter(dir)
                ? 0
                : width / 6
            : null,
        child: Transform.rotate(
          angle: pi / 2 - pi / 3.0 * dir.index.toDouble(),
          child: TriangularHexagonPieceWidget(
            width: height / 3,
            height: height / 3,
            type: field[dir].type,
          ),
        ));
  }
}

class CustomTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class TriangularHexagonPieceWidget extends StatelessWidget {
  final double width;
  final double height;
  final FieldType type;

  const TriangularHexagonPieceWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomTriangleClipper(),
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(color: Colors.blue),
        child: Column(
          children: [
            Text(type.name),
          ],
        ),
      ),
    );
  }
}
