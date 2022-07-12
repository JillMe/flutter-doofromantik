import 'package:flutter/material.dart';
import 'package:hexagon/services/game.dart';
import 'package:hexagon/widgets/board_widget.dart';
import 'package:hexagon/widgets/hexagon_widget.dart';

import 'model/hex_field.dart';
import 'model/pointy_hexagon.dart';

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
        ),
      ),
    );
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

const size = 50;

const offset = size * 5;

class MyStatelessWidget extends StatelessWidget {
  final HexFieldGrid grid;
  const MyStatelessWidget({Key? key, required this.grid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(20.0),
        minScale: 0.1,
        maxScale: 25,
        child: BoardWidget(
          board: grid.grid,
          size: 50 * 30,
        ),
      ),
    );
  }
}
