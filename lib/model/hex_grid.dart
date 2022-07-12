import 'dart:collection';

import 'package:hexagon/model/pointy_hexagon.dart';

class PointyHexGrid<T> {
  final Map<PointyHexagon, T> _grid = HashMap<PointyHexagon, T>();
  final Set<PointyHexagon> _availablePlaces = HashSet();
  bool Function(T existing, PointyHexagonalDirection dir, T incomingType)
      isCompatible;

  PointyHexGrid(this.isCompatible) {
    _availablePlaces.add(const PointyHexagon.fromAxial(q: 0, r: 0));
  }

  T? getNeighbor(PointyHexagon hex, PointyHexagonalDirection dir) {
    return this[hex + dir.hex];
  }

  T? operator [](PointyHexagon hex) {
    return _grid[hex];
  }

  Iterable<PointyHexagon> get availablePlaces => _availablePlaces;

  get length => _grid.length;

  void clear() {
    _grid.clear();
    _availablePlaces.clear();
    _availablePlaces.add(PointyHexagon.origin);
  }

  Iterable<MapEntry<PointyHexagon, T>> get entries => _grid.entries;

  void operator []=(PointyHexagon hex, T value) {
    assert(_availablePlaces.contains(hex), "Can't put on an unavailable field");
    assert(!_grid.containsKey(hex), "Can't put on occupied field");
    var newPlaces = <PointyHexagon>[];
    for (PointyHexagonalDirection dir in PointyHexagonalDirection.values) {
      final next = hex + dir.hex;
      final existing = this[next];
      if (existing == null) {
        newPlaces.add(next);
      } else if (!isCompatible(existing, dir, value)) {
        return;
      }
    }
    _grid[hex] = value;
    _availablePlaces.remove(hex);
    _availablePlaces.addAll(newPlaces);
  }
}
