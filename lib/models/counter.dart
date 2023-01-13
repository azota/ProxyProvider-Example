import 'package:flutter/foundation.dart';

class CounterModel extends ChangeNotifier {
  CounterModel() {
    print('CounterModel > constructor');
  }

  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}
