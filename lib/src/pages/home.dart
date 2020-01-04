import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var screenSize =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              height: screenSize / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Hello! Sean",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Destination",
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Color.fromRGBO(32, 176, 212, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(),
                  SizedBox(
                    height: 32.0,
                  ),
                  FlatButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 80.0, vertical: 14.0),
                    textColor: Colors.white,
                    child: Text(
                      "Start",
                      style: TextStyle(fontSize: 24.0),
                    ),
                    color: Color.fromRGBO(0, 177, 79, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    onPressed: () => {},
                  )
                ],
              ),
            ),
            // Container(
            //   height: screenSize / 2,
            //   color: Color.fromRGBO(r, g, b, opacity),
            // ),
          ],
        ),
      ),
    );
  }
}
