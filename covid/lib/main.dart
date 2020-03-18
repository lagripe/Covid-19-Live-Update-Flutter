import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Pages/Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            unselectedWidgetColor: Colors.white,
          ),
          home: Home())));
}
