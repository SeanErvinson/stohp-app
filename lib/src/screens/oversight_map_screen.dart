import 'package:flutter/material.dart';
import 'package:stohp/src/components/home/services/view/oversight_map.dart';
import 'package:stohp/src/values/values.dart';

class OversightMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            OversightMap(),
            Positioned(
              top: 10,
              left: 10,
              child: FloatingActionButton.extended(
                onPressed: () => Navigator.of(context).pop(),
                foregroundColor: colorSecondary,
                backgroundColor: Colors.white,
                icon: Icon(
                  Icons.arrow_back,
                  size: 16.0,
                ),
                label: Text(
                  Strings.back,
                  style: primaryAppText.copyWith(fontSize: 12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
