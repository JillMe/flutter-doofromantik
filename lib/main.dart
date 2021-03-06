import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon/model/hex_grid.dart';
import 'package:hexagon/model/pointy_hexagon.dart';
import 'package:hexagon/services/game.dart';
import 'package:hexagon/widgets/board_widget.dart';

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
            IconButton(onPressed: _resetBoard, icon: const Icon(Icons.replay)),
            IconButton(onPressed: _addNormal, icon: const Icon(Icons.plus_one)),
            IconButton(onPressed: _addPerfect, icon: const Icon(Icons.star)),
          ],
        ),
        body: MyStatelessWidget(
          grid: widget.game.board,
          bounds: widget.game.boundingRect(),
          onTapAvailable: _addTile,
        ),
      ),
    );
  }

  void _addTile(PointyHexagon hex) {
    setState(() {
      widget.game.addValidTile(target: hex, perfect: true);
    });
  }

  void _addPerfect() {
    setState(() {
      widget.game.addValidTile(perfect: true);
    });
  }

  void _addNormal() {
    setState(() {
      widget.game.addValidTile(perfect: false);
    });
  }

  void _resetBoard() {
    setState(() {
      widget.game.reset();
    });
  }
}

class MyStatelessWidget extends StatelessWidget {
  final PointyHexGrid<HexField> grid;
  final Rectangle bounds;
  final Function(PointyHexagon point) onTapAvailable;
  const MyStatelessWidget(
      {Key? key,
      required this.grid,
      required this.bounds,
      required this.onTapAvailable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(20.0),
      constrained: false,
      minScale: 0.1,
      maxScale: 25,
      child: BoardWidget(
        board: grid,
        bounds: bounds,
        onTapAvailable: onTapAvailable,
      ),
    );
  }
}
