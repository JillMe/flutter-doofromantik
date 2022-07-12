import 'package:flutter/material.dart';
import 'package:hexagon/model/hex_field.dart';
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
        body: const MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(20.0),
        minScale: 0.1,
        maxScale: 25,
        child: Container(
          width: 500,
          height: 500,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.orange, Colors.red],
              stops: <double>[0.0, 1.0],
            ),
          ),
          child: Stack(
            children: <Widget>[
              HexagonWidget.fromSize(
                field: HexField.fromEdge([
                  const HexEdge(type: FieldType.grass),
                  const HexEdge(type: FieldType.forest),
                  const HexEdge(type: FieldType.village),
                  const HexEdge(type: FieldType.plain),
                  const HexEdge(type: FieldType.train),
                  const HexEdge(type: FieldType.river)
                ]),
                size: 150,
              )
            ],
          ),
        ),
      ),
    );
  }
}
