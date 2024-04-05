import 'dart:math' as math show Random;

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
  T getRandomElement1() => elementAt(math.Random().nextInt(length));

}
