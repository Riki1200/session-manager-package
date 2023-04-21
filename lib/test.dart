import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'unsupported.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SessionActivityManager(
        child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Text('Hello World'),
    ));
  }
}
