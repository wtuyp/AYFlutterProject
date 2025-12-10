

import 'package:app/manager/account_manager/account_info_model.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

// 全局，不推荐
final globalCounter = signal(0);

class SignalsDemoPage extends StatefulWidget {
  const SignalsDemoPage({super.key});

  @override
  State<SignalsDemoPage> createState() => _SignalsDemoPageState();
}

class _SignalsDemoPageState extends State<SignalsDemoPage> with SignalsMixin {
  late final _counter = createSignal(10.0);
  late final _text = createSignal('10.0');
  late final _user = createSignal(UserModel(
    name: 'Tom',
    age: 25,
  ));
  late final _userAge = _user.select((s) => s.value.age!);

  late final doubleCount = createComputed(() => _counter.value * 2);

  // 副作用？
  late final _disposeEffect = createEffect(() {
    debugPrint('count: $_counter, double: $doubleCount');
  });

  void tapAction() {
    batch(() {

      _counter.value++;
      globalCounter.value++;
      _text.value = _counter.value.toString();



      // 不会引起 _userAge 的变化
      // _user.value.age = _user.value.age! + 1;
      // 强制刷新
      // _user.set(_user.value, force: true);

      // 会引起 _userAge 的变化
      _user.value = _user.value.copyWith(
        age: _user.value.age! + 1,
      );

    });

  }

  @override
  void initState() {
    super.initState();



    /*
    final count = signal(0);

    assert(count is Signal<int>);
    assert(count is FlutterSignal<int>);
    assert(count is FlutterReadonlySignal<int>);
    assert(count is ValueNotifier<int>);

    final count = computed(() => 0);

    assert(count is Signal<int>);
    assert(count is FlutterComputed<int>);
    assert(count is FlutterReadonlySignal<int>);
    assert(count is ValueListenable<int>);

    */
  }

  @override
  void dispose() {
    _disposeEffect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signals Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter and $_text',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: _counter.value,
              ),
            ),
            Text(
              'Name: ${_user.value.name!}, Age: ${_user.value.age!}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Select Age: $_userAge',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Double: $doubleCount',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Global Counter: $globalCounter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: tapAction,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
