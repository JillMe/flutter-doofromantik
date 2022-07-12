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
}

class PointyHexagon {
  final int q;
  final int r;
  final int s;

  const PointyHexagon({required this.q, required this.r, required this.s}) {
    assert(q + r + s == 0, "Cube coordinates have to always follow q+r+s = 0");
  }

  const PointyHexagon.fromAxial({required int q, required int r})
      : this(q: q, r: r, s: -r - q);

  operator +(PointyHexagon b) {
    return PointyHexagon(q: q + b.q, r: r + b.r, s: s + b.s);
  }

  operator -(PointyHexagon b) {
    return PointyHexagon(q: q - b.q, r: r - b.r, s: s - b.s);
  }

  operator ==(Object b) {
    if (b is PointyHexagon) {
      return q == b.q && r == b.r && s == b.s;
    }
    return false;
  }

  @override
  int get hashCode => "$q,$r".hashCode;

  @override
  String toString() => "PointyHexagon{q:$q,r:$r,s:$s)";
}
