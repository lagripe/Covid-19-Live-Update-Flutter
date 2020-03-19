import 'dart:async';

import 'package:flutter/material.dart';

import 'Home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2000), () {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Image(
            width: MediaQuery.of(context).size.width -
                (MediaQuery.of(context).size.width * .5),
            height: MediaQuery.of(context).size.width -
                (MediaQuery.of(context).size.width * .5),
            image: AssetImage('assets/imgs/logo.png'),
          ),
        ),
      ),
    );
  }
}
