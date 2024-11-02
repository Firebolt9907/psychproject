import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psych_project/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple, brightness: Brightness.light),
        useMaterial3: true,
      ),
      home: const TimeTraveller(title: 'Flutter Demo Home Page'),
    );
  }
}

class TimeTraveller extends StatefulWidget {
  const TimeTraveller({super.key, required this.title});
  final String title;

  @override
  State<TimeTraveller> createState() => _TimeTravellerState();
}

class _TimeTravellerState extends State<TimeTraveller> {
  double _counter = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
              width: 200,
              color: Theme.of(context).colorScheme.inversePrimary,
              child: Column(
                children: [
                  CupertinoNavigationBar(
                    middle: Text(
                      "Time Traveller",
                    ),
                    backgroundColor: Colors.transparent,
                    border: Border.all(color: Colors.transparent),
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).height - 80,
                      child: CupertinoSlider(
                          value: _counter,
                          min: 1,
                          max: 225,
                          divisions: 224,
                          onChanged: (u) {
                            _counter = u;
                            setState(() {});
                          }),
                    ),
                  ),
                  Text("Drag slider to change child's age",
                      style: TextStyle(
                          fontSize: 12, color: Color.fromARGB(255, 52, 0, 61)))
                ],
              )),
          SizedBox(
            width: MediaQuery.sizeOf(context).width - 200,
            child: HomePage(age: _counter),
          ),
        ],
      ),
    );
  }
}
