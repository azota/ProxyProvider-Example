import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/counter.dart';

class CounterText extends StatelessWidget {
  const CounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterModel>();

    return Text(
      '${counter.counter}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
