import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stohp/src/screens/home.dart';
import './values/styles.dart';

void main() => runApp(StohpApp());

class StohpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stohp',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.blue,
        textTheme: TextTheme(button: button, title: title, subtitle: subtitle),
      ),
      home: HomePage(),
    );
  }
}
