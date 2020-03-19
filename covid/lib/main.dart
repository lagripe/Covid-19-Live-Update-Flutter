import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Pages/SplashPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (_) => runApp(MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              unselectedWidgetColor:  Colors.grey[900],
              scaffoldBackgroundColor: Colors.grey[200],
              appBarTheme: AppBarTheme(color: Colors.grey[200])),
          home: SplashScreen())));
}
