import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon/model/hex_field.dart';
import 'package:hexagon/model/pointy_hexagon.dart';

import 'triangle_piece.dart';

typedef Dir = PointyHexagonalDirection;

class CustomHexagonClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    var padding = 5.0;
    var height = size.height - 2 * padding;
    var width = size.width - 2 * padding;
    path.lineTo(width / 2 + padding, padding);
    path.lineTo(width + padding, height / 4 + padding);
    path.lineTo(width + padding, height * 3 / 4 + padding);
    path.lineTo(width / 2 + padding, height + padding);
    path.lineTo(padding, height * 3 / 4 + padding);
    path.lineTo(padding, height / 4 + padding);
    path.lineTo(width / 2 + padding, padding);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HexagonWidget extends StatelessWidget {
  final HexField? field;
  final double width;
  final double height;
  final double size;
  final bool debug;
  final void Function()? onTap;
  const HexagonWidget({
    Key? key,
    this.field,
    required this.width,
    required this.height,
    required this.size,
    this.debug = false,
    this.onTap,
  }) : super(key: key);

  factory HexagonWidget.fromSize(
      {Key? key,
      HexField? field,
      double size = 20,
      bool debug = false,
      void Function()? onTap}) {
    return HexagonWidget(
        field: field,
        width: sqrt(3) * size,
        height: 2 * size,
        debug: debug,
        size: size,
        key: key,
        onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (field != null) {
      if (debug) {
        child = ClipPath(
          clipper: CustomHexagonClip(),
          child: Container(
            color: Colors.green,
          ),
        );
      } else {
        child = Stack(children: field!.edges.entries.map(_tileForDir).toList());
      }
    } else {
      child = ClipPath(
        clipper: CustomHexagonClip(),
        child: GestureDetector(
          onTap: onTap ?? () => print("fun"),
          child: Container(
            color: Colors.red,
          ),
        ),
      );
    }
    return SizedBox(width: width, height: height, child: child);
  }

  Widget _tileForDir(MapEntry<Dir, HexEdge> entry) {
    return Positioned(
        top: size / 8,
        left: size / 2 - 7,
        child: Transform.rotate(
          angle: pi / 2.0 - pi / 3.0 * entry.key.index.toDouble(),
          alignment: Alignment.bottomCenter,
          child: TriangularHexagonPieceWidget(
            width: size,
            height: width / 2,
            type: entry.value.type,
          ),
        ));
  }
}
