import 'dart:math';

int random(min, max) {
  final rn = Random();
  return min + rn.nextInt(max - min);
}
