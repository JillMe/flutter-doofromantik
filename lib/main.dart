import 'package:flutter/material.dart';
import 'package:hexagon/services/game.dart';
import 'package:hexagon/widgets/hexagon_widget.dart';

import 'model/hex_field.dart';

void main() => runApp(MyGame());

class MyGame extends StatefulWidget {
  final Game game = Game.startWithAllTypes();
  MyGame({Key? key}) : super(key: key);

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Doofromantik",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Doofromantik"),
          actions: [
            IconButton(onPressed: _addPerfect, icon: const Icon(Icons.plus_one))
          ],
        ),
        body: MyStatelessWidget(
          grid: widget.game.grid,
        ),
      ),
    );
  }

  void _addPerfect() {
    setState(() {
      widget.game.addValidTile(perfect: true);
    });
  }
}

const size = 50;

const offset = size * 5;

class MyStatelessWidget extends StatelessWidget {
  final HexFieldGrid grid;
  MyStatelessWidget({Key? key, required this.grid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(20.0),
        minScale: 0.1,
        maxScale: 25,
        child: Container(
          width: size * 30,
          height: size * 30,
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
    for (var key in grid.grid.keys) {
      var field = grid[key];
      if (field == null) {
        continue;
      }
      final p = key.toPixel(size.toDouble());
      widgets.add(Positioned(
          left: offset + p.x.toDouble(),
          top: offset + p.y.toDouble(),
          child: HexagonWidget.fromSize(field: field, size: size.toDouble())));
    }
    return widgets;
  }
}
