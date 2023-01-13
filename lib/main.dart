import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/counter.dart';
import 'models/value_info.dart';
import 'widgets/counter_text.dart';
import 'widgets/value_info_text.dart';

/// https://terry1213.github.io/flutter/flutter-provider/
/// Consumer는 위에서 말한 context.watch<T>(), context.read<T>()(혹은 Provider.of(context))를 사용할 수 없을 때 사용한다.
/// 그렇다면 그런 경우는 언제일까?
/// 하나의 build 메소드에서 Provider를 생성도 하고 소비도 해야하는 상황이다. 이 때는 Consumer를 사용해야 Provider를 소비할 수 있다
///
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('MyApp > build');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterModel>(
          create: (_) => CounterModel(),
        ),

        // case1
        //최초 로딩시에도 update 실행됨
        ChangeNotifierProxyProvider<CounterModel, ValueInfoModel>(
          create: (_) => ValueInfoModel(-1),
          update: (_, counter, valueInfo) {
            valueInfo!.update(counter);
            return valueInfo;
          },
        ),

        // case2
        // 두번째건 이렇게 하면 인스턴스 안생김
        /* ChangeNotifierProvider<ValueInfoModel>(
          create: (_) => ValueInfoModel(),
        ), */
        // valueInfo 최초 null, 다음부터 인스턴스 넘어옴
        /* ListenableProxyProvider<CounterModel, ValueInfoModel>(
          update: (_, counter, valueInfo) {
            print('update: $valueInfo');
            return ValueInfoModel(counter.counter);
          },
        ), */
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
    print('MyHomePage > build');

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
        // 함수호출은 UI변경이 필요 없으므로 read 사용
        // read: 버튼 클릭시 build함수(MyHomePage > build) 호출 안됨
        // watch: 버튼 클릭시 build함수 호출 매번 호출됨
        onPressed: context.read<CounterModel>().increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
