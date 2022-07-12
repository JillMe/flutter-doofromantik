import 'dart:collection';

import 'package:hexagon/model/pointy_hexagon.dart';

class PointyHexGrid<T> {
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
    grid[hex] = value;
    availablePlaces.remove(hex);
    for (PointyHexagonalDirection dir in PointyHexagonalDirection.values) {
      final next = hex + dir.hex;
      if (!grid.containsKey(next)) {
        availablePlaces.add(next);
      }
    }
  }
}
