import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psych_project/data.dart';

class HomePage extends StatefulWidget {
  final double age;

  const HomePage({super.key, required this.age});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var substageIndex = -1;
  var stageIndex = -1;
  dynamic substageData = {"info": ""};
  dynamic stageData = {"info": ""};
  var age = 0;

  @override
  void initState() {
    data = data["stages"];
    checkStage();
    super.initState();
  }

  checkStage() async {
    var age = widget.age.round() - 9;

    for (var i = 0; i < data.length; i++) {
      if (data[i]["lowAge"] <= age && data[i]["highAge"] > age) {
        stageIndex = i;
        stageData = data[i];
      }
    }

    var otherData = stageData["substages"];
    for (var j = 0; j < otherData.length; j++) {
      if (otherData[j]["lowAge"] <= age && otherData[j]["highAge"] > age) {
        substageIndex = j;
        substageData = otherData[j];
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    checkStage();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(widget.age <= 9
            ? "Age of Child: ${widget.age.round()} Month${widget.age.round() == 1 ? "" : "s"} Pregnant"
            : 'Age of Child: ${widget.age.round() > 20 ? '${(widget.age.round() - 9) ~/ 12} Year${(widget.age.round() - 9) ~/ 12 == 1 ? "" : "s"}' : ""}${widget.age > 21 && (widget.age.round() - 9) % 12 != 0 ? ' and ' : ""}${(widget.age.round() - 9) % 12 == 0 ? "" : '${(widget.age.round() - 9) % 12} Month${(widget.age.round() - 9) % 12 == 1 ? "" : "s"} Old'}'),
        border: Border.all(color: Colors.transparent),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: ListView(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.

          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                    "Your Child is in the ${stageIndex != -1 ? data[stageIndex]["name"] : "[Error]"} Stage",
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.15),
              child: Text(stageData["info"] + substageData["info"],
                  style: Theme.of(context).textTheme.bodyLarge),
            )
          ],
        ),
      ),
    );
  }
}
