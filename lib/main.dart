import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/counter.dart';
import 'models/value_info.dart';
import 'widgets/counter_text.dart';
import 'widgets/value_info_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterModel>(
          create: (_) => CounterModel(),
        ),
        ChangeNotifierProxyProvider<CounterModel, ValueInfoModel>(
          create: (_) => ValueInfoModel(),
          update: (_, counter, valueInfo) {
            valueInfo!.update(counter);
            return valueInfo;
          },
        ),
      ],
      child: MaterialApp(
        title: 'ProxyProvider Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ProxyProvider Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CounterText(),
            SizedBox(height: 10),
            ValueInfoText()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read<CounterModel>().increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
