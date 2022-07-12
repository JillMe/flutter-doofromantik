import 'dart:collection';

import 'package:hexagon/model/pointy_hexagon.dart';

abstract class PointyHexGrid<T> {
  Map<PointyHexagon, T> grid = HashMap<PointyHexagon, T>();
  Set<PointyHexagon> availablePlaces = HashSet();

  PointyHexGrid();

  getNeighbor(PointyHexagon hex, PointyHexagonalDirection dir) {
    return this[hex + dir.hex];
  }

  T? operator [](PointyHexagon hex) {
    return grid[hex];
  }

  void operator []=(PointyHexagon hex, T value) {
    assert(availablePlaces.contains(hex),
        "Can't put on an already occupied field");
    var newPlaces = <PointyHexagon>[];
    for (PointyHexagonalDirection dir in PointyHexagonalDirection.values) {
      final next = hex + dir.hex;
      if (!grid.containsKey(next)) {
        newPlaces.add(next);
      } else if (!compatibleWithNeighbor(next, dir, value)) {
        return;
      }
    }
    grid[hex] = value;
    availablePlaces.remove(hex);
    availablePlaces.addAll(newPlaces);
  }

  bool compatibleWithNeighbor(
      PointyHexagon existing, PointyHexagonalDirection dir, T incomingType);
}
