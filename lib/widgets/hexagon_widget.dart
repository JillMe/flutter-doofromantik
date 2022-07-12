import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon/model/pointy_hexagon.dart';
import 'package:hexagon/util/const.dart';

typedef Dir = PointyHexagonalDirection;

class HexagonClipper extends CustomClipper<Path> {
  HexagonClipper(this.pathBuilder);

  final HexagonPathBuilder pathBuilder;

  @override
  Path getClip(Size size) {
    return pathBuilder.build(size);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    if (oldClipper is HexagonClipper) {
      return oldClipper.pathBuilder != pathBuilder;
    }
    return true;
  }
}

class HexagonPainter extends CustomPainter {
  HexagonPainter(this.pathBuilder,
      {this.color = Colors.white, this.elevation = 0});

  final HexagonPathBuilder pathBuilder;
  final double elevation;
  final Color color;

  final Paint _paint = Paint();
  Path _path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    _path = pathBuilder.build(size);
    _paint.color = color;
    _paint.isAntiAlias = true;
    _paint.style = PaintingStyle.fill;

    if ((elevation) > 0) {
      canvas.drawShadow(_path, Colors.black, elevation, false);
    }
    canvas.drawPath(_path, _paint);
  }

  @override
  bool hitTest(Offset position) {
    return _path.contains(position);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HexagonPainter &&
          runtimeType == other.runtimeType &&
          pathBuilder == other.pathBuilder &&
          elevation == other.elevation &&
          color == other.color;

  @override
  int get hashCode =>
      pathBuilder.hashCode ^ elevation.hashCode ^ color.hashCode;
}

class HexagonPathBuilder {
  Path build(Size size) {
    final path = Path();
    var padding = 0.0;
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
}

class CustomHexagonClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    var padding = 0.0;
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
  final double width;
  final double height;
  final Widget child;
  final double padding;
  final double elevation;
  const HexagonWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.child,
    required this.padding,
    required this.elevation,
  }) : super(key: key);

  factory HexagonWidget.standard(
      {Key? key,
      required Widget child,
      double elevation = 0.0,
      double padding = 0.0}) {
    return HexagonWidget(
        width: sqrt(3) * hexagonSize,
        height: 2 * hexagonSize,
        key: key,
        elevation: elevation,
        padding: padding,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    HexagonPathBuilder pathBuilder = HexagonPathBuilder();

    return Align(
      child: Container(
        padding: EdgeInsets.all(padding),
        width: width,
        height: height,
        child: CustomPaint(
          painter: HexagonPainter(pathBuilder, elevation: elevation),
          child: ClipPath(
            clipper: HexagonClipper(pathBuilder),
            child: OverflowBox(
              alignment: Alignment.center,
              maxHeight: height - padding,
              maxWidth: width - padding,
              child: Align(
                alignment: Alignment.center,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
    // return SizedBox(
    //     width: width,
    //     height: height,
    //     child: ClipPath(
    //       clipper: CustomHexagonClip(),
    //       child: child,
    //     ));
  }
}
