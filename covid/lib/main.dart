import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Pages/Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MaterialApp(
          theme: ThemeData(
            unselectedWidgetColor: Colors.white,
          ),
          home: Home())));
}
