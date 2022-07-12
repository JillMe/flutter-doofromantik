enum PointyHexagonalDirection {
  right(PointyHexagon.fromAxial(q: 1, r: 0)),
  topRight(PointyHexagon.fromAxial(q: 1, r: -1)),
  topLeft(PointyHexagon.fromAxial(q: 0, r: -1)),
  left(PointyHexagon.fromAxial(q: -1, r: 0)),
  bottomLeft(PointyHexagon.fromAxial(q: -1, r: 1)),
  bottomRight(PointyHexagon.fromAxial(q: 0, r: 1)),
  ;

  final PointyHexagon hex;

  const PointyHexagonalDirection(this.hex);

  static PointyHexagonalDirection invert(PointyHexagonalDirection dir) {
    switch (dir) {
      case PointyHexagonalDirection.right:
        return PointyHexagonalDirection.left;
      case PointyHexagonalDirection.topRight:
        return PointyHexagonalDirection.bottomLeft;
      case PointyHexagonalDirection.topLeft:
        return PointyHexagonalDirection.bottomRight;
      case PointyHexagonalDirection.left:
        return PointyHexagonalDirection.right;
      case PointyHexagonalDirection.bottomLeft:
        return PointyHexagonalDirection.topRight;
      case PointyHexagonalDirection.bottomRight:
        return PointyHexagonalDirection.topLeft;
    }
  }
}

class PointyHexagon {
  final int q;
  final int r;
  final int s;

  const PointyHexagon({required this.q, required this.r, required this.s});

  const PointyHexagon.fromAxial({required int q, required int r})
      : this(q: q, r: r, s: -r - q);

  operator +(PointyHexagon b) {
    return PointyHexagon(q: q + b.q, r: r + b.r, s: s + b.s);
  }

  operator -(PointyHexagon b) {
    return PointyHexagon(q: q - b.q, r: r - b.r, s: s - b.s);
  }

  @override
  operator ==(Object other) {
    if (other is PointyHexagon) {
      return q == other.q && r == other.r && s == other.s;
    }
    return false;
  }

  @override
  int get hashCode => "$q,$r".hashCode;

  @override
  String toString() => "PointyHexagon{q:$q,r:$r,s:$s)";
}
