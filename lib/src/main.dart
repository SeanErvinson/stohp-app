import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stohp/src/pages/home.dart';

void main() => runApp(StohpApp());

class StohpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stohp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
