import 'dart:math';

final r = Random(1337);

T pickRandom<T>(Iterable<T> iterable) =>
    iterable.elementAt(r.nextInt(iterable.length));

class Weighted<T> {
  final double prob;
  final T value;
  const Weighted(this.value, this.prob);
}

T pickWeighted<T>(Iterable<Weighted<T>> weights) {
  var maxProb = weights.fold<double>(
      0, (previousValue, element) => previousValue + element.prob);
  var roll = r.nextDouble() * maxProb;
  for (Weighted<T> current in weights) {
    roll -= current.prob;
    if (roll < 0) {
      return current.value;
    }
  }
  return weights.last.value;
}
