import 'package:flutter/material.dart';
import 'package:stohp/src/values/values.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _usableScreenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Image.asset(
                    "assets/icons/logo-banner.png",
                    width: 180.0,
                  ),
                ),
              ),
            ),
            Container(
              height: _usableScreenHeight * .05,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [logoSecondary, logoPrimary])),
            ),
          ],
        ),
      ),
    );
  }
}
