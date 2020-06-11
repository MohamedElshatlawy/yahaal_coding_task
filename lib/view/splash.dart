import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yahaal_task/Api/readFile.dart';

import '../constant.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> onDoneLoading() async {
    await mappingFileToUser().then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => HomeScreen(
                    users: value,
                  )));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _visible = true;
      });
    });
  }

  bool _visible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AnimatedOpacity(
        // If the widget is visible, animate to 0.0 (invisible).
        // If the widget is hidden, animate to 1.0 (fully visible).
        opacity: _visible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 3000),
        onEnd: () {
          onDoneLoading();
        },
        // The green box must be a child of the AnimatedOpacity widget.
        child: Text(
          'Yahaal',
          style: TextStyle(
              color: Constants.MyColor,
              fontFamily: 'italy',
              fontWeight: FontWeight.w400,
              fontSize: 58),
        ),
      )),
    );
  }
}
