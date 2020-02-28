import 'package:flutter/material.dart';
import 'package:stohp/src/values/values.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _usableScreenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Center(
                child: Image.asset(
                  "assets/icons/logo-banner-foreground.png",
                  width: 180.0,
                ),
              ),
            ),
            Container(
              height: _usableScreenHeight * .05,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [colorSecondary, colorPrimary])),
            ),
          ],
        ),
      ),
    );
  }
}
