import 'package:flutter/material.dart';

import '../model/field_type.dart';

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
        decoration: BoxDecoration(color: type.color()),
      ),
    );
  }
}
