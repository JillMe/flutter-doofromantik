import 'package:flutter/material.dart';
import 'package:hexagon/model/hex_field.dart';
import 'package:hexagon/model/pointy_hexagon.dart';
import 'package:hexagon/services/game.dart';
import 'package:hexagon/widgets/hexagon_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatelessWidget(),
      ),
    );
  }
}

const size = 100.0;

const offset = 0;

class MyStatelessWidget extends StatelessWidget {
  final Game game = Game.example();
  MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(20.0),
        minScale: 0.1,
        maxScale: 25,
        child: Container(
          width: 1000,
          height: 1000,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.orange, Colors.red],
              stops: <double>[0.0, 1.0],
            ),
          ),
          child: Stack(
            children: _buildGameTiles(),
          ),
        ),
      ),
    );
  }

  _buildGameTiles() {
    List<Widget> widgets = [];
    for (var key in game.grid.grid.keys) {
      var field = game.grid[key];
      if (field == null) {
        continue;
      }
      final p = key.toPixel(size);
      widgets.add(Positioned(
          left: offset + p.x.toDouble(),
          top: offset + p.y.toDouble(),
          child: HexagonWidget.fromSize(field: field, size: size)));
    }
    return widgets;
  }
}
