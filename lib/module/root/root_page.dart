

import 'package:app/module/demo/json_model_demo_page.dart';
import 'package:app/module/demo/refresh_demo_page.dart';
import 'package:app/module/demo/signals_demo_page.dart';
import 'package:app/module/demo/toast_demo_page.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('首页'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Refresh Demo"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const RefreshDemoPage()));
            },
          ),
          ListTile(
            title: Text("Signals Demo"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignalsDemoPage()));
            },
          ),
          ListTile(
            title: Text("Json Model Demo"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const JsonModelDemoPage()));
            },
          ),
          ListTile(
            title: Text("Toast Demo"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ToastDemoPage()));
            },
          ),
          ListTile(
            title: Text('App status'),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have pushed the button this many times:'),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
