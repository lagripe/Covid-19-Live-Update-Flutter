import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String header, stat;
  final color;
  StatCard({@required this.header, @required this.stat, @required this.color});
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.grey[900],
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                header,
                style: TextStyle(fontSize: 25, fontFamily: "Proxima",color: Colors.white),
              ),
              SizedBox(height: 15),
              Text(stat,
                  style: TextStyle(
                      fontSize: 30, fontFamily: "Proxima", color: color))
            ],
          ),
        ));
  }
}
