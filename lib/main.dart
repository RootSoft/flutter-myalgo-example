import 'package:flutter/material.dart';
import 'package:myalgo_example/interop/myalgo_interop.dart';
import 'package:myalgo_example/myalgo_exception.dart';
import 'package:myalgo_example/myalgo_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _platformVersion = 'Unknown';
  final plugin = MyAlgoPlugin(myAlgo: MyAlgoConnect());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              final accounts = await plugin.connect();
              print(accounts);
            } on MyAlgoException catch (ex) {
              print('unable to connect ${ex.message}');
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
