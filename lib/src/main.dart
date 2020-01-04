import 'package:flutter/material.dart';
import 'package:stohp/src/pages/home.dart';

void main() => runApp(StohpApp());

class StohpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
