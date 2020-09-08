import 'dart:async';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test application',
      home: TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestPageState();
  }
}

class _TestPageState extends State<TestPage> {
  double _progress = 0;
  Timer _timer;

  void _startProgressAnimation() {
      _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
        setState(() {
          if (_progress < 1) {
            _progress = _progress + 0.001;
          } else {
            _progress = 1;
            _timer.cancel();
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_progress.toString()),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            height: 50,
            width: 200,
            child: LiquidLinearProgressIndicator(
              value: _progress, // Defaults to 0.5.
              valueColor: AlwaysStoppedAnimation(Hexcolor("#FFA07A")), // Defaults to the current Theme's accentColor.
              backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
              borderColor: Colors.red,
              borderWidth: 5.0,
              borderRadius: 12.0,
              direction: Axis.horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
              center: Text("Loading..."),
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _startProgressAnimation,
      ),
    );
  }
}

/*
class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 50,
          width: 200,
          child: LiquidLinearProgressIndicator(
            value: 0.25, // Defaults to 0.5.
            valueColor: AlwaysStoppedAnimation(Colors.pink), // Defaults to the current Theme's accentColor.
            backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
            borderColor: Colors.red,
            borderWidth: 5.0,
            borderRadius: 12.0,
            direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
            center: Text("Loading..."),
          ),
        ),
      )
    );
  }
}
*/
