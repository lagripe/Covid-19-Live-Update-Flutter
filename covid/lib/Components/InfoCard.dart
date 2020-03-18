import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String header, stat;
  final color;
  InfoCard({@required this.header, this.stat, @required this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
      child: Container(
        height: 200,
        child: Card(
          color: Colors.grey[300],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                header,
                style: TextStyle(fontSize: 50, fontFamily: "Proxima"),
              ),
              SizedBox(height: 15),
              Text(stat,
                  style: TextStyle(
                      fontSize: 32,
                      fontFamily: "Proxima",
                      color: color))
            ],
          ),
        ),
      ),
    );
  }
}
