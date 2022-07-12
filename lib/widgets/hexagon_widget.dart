import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon/model/hex_field.dart';
import 'package:hexagon/model/pointy_hexagon.dart';

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
        decoration: BoxDecoration(color: _color(type)),
        child: Text(
          type.name,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static Color? _color(FieldType type) {
    switch (type) {
      case FieldType.village:
        return Colors.grey;
      case FieldType.forest:
        return Colors.green[900];
      case FieldType.plain:
        return Colors.deepOrange;
      case FieldType.grass:
        return Colors.green[200];
      case FieldType.river:
        return Colors.blue[700];
      case FieldType.train:
        return Colors.brown;
    }
  }
}
