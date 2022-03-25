import 'dart:math';
import 'package:flutter/foundation.dart';
import 'counter.dart';

class ValueInfoModel with ChangeNotifier {
  late int _value;

  void update(CounterModel counter) {
    _value = counter.counter;
    notifyListeners();
  }

  String get infoString {
    String str = '';
    switch (_value) {
      case 0:
        str = 'Click "+" button to increase counter';
        break;
      case 1:
        str = 'Try yet another time';
        break;
      case 2:
        str = 'Two is an even number!';
        break;
      case 3:
        str = 'Go on! There will be some calculations...';
        break;
      default:
        str = 'The list of prime divisors of $_value: ${_factorize(_value)}';
    }
    return str;
  }

  List<int> _factorize(int x) {
    final factors = <int>{};
    for (int i = 2; i <= sqrt(x); i++) {
      while (x % i == 0) {
        factors.add(i);
        x = x ~/ i;
      }
    }
    if (x != 1) factors.add(x);
    return factors.toList();
  }
}
