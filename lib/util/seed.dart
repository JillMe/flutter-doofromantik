import 'dart:math';

final r = Random(1337);

T pickRandom<T>(Iterable<T> iterable) =>
    iterable.elementAt(r.nextInt(iterable.length));
