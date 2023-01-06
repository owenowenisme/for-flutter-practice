import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speed Test',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black87,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Click Speed Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double cps = 0;
  int sec = 5;
  bool flag = false;
  late Timer _timer;
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Restart"),
      onPressed: () {
        Navigator.pop(context);
        setState(() {
          _counter = 0;
          sec = 5;
          flag = false;
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Result",
        style: TextStyle(color: Colors.white),
      ),
      content: Text(
        "Your Cps is $cps\n我阿嬤都比你快",
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black87,
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void set_timer() {
    flag = true;
    const onesec = Duration(seconds: 1);
    _timer = Timer.periodic(
      onesec,
      (Timer timer) {
        if (sec == 0) {
          setState(() {
            timer.cancel();
            cps = _counter / 5;
          });

          showAlertDialog(context);
        } else {
          setState(() {
            sec--;
          });
        }
      },
    );
  }

  void _incrementCounter() {
    if (sec > 0) {
      setState(() {
        _counter++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text.rich(
              TextSpan(
                children: [
                  const WidgetSpan(
                      child: Icon(
                    Icons.timer,
                    color: Colors.white,
                    size: 36,
                  )),
                  TextSpan(
                    text: '$sec sec',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
              ),
            ),
            Text(
              '$_counter',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 72,
              ),
            ),
            FloatingActionButton.extended(
              label: const Text(
                'CLICK!',
              ),
              icon: const Icon(Icons.add),
              onPressed: () => [
                //showAlertDialog(context),
                if (!flag) set_timer(),
                _incrementCounter()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
