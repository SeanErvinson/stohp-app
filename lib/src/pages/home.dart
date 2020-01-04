import 'package:flutter/material.dart';
import '../values/values.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController destinationInputController =
        TextEditingController();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              height: screenHeight / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Hello! Sean",
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  Text(
                    Strings.destination,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 24.0),
                    width: 240.0,
                    child: TextField(
                      maxLines: 1,
                      minLines: 1,
                      controller: destinationInputController,
                      textAlign: TextAlign.center,
                      toolbarOptions: ToolbarOptions(
                          paste: true, copy: true, cut: true, selectAll: true),
                      style: TextStyle(),
                    ),
                  ),
                  FlatButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 80.0, vertical: 12.0),
                    textColor: Colors.white,
                    child: Text(
                      Strings.start,
                      style: Theme.of(context).textTheme.button,
                    ),
                    color: Color.fromRGBO(0, 177, 79, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    onPressed: () => print(destinationInputController.text),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(48.0),
                  topRight: Radius.circular(48.0),
                ),
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 48.0),
              height: screenHeight / 2,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 16.0, left: 4.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Strings.activityHeader,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Home",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text("10/02/2019"),
                                  Text("10:00pm"),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Icon(Icons.keyboard_arrow_up),
                    onVerticalDragUpdate: (DragUpdateDetails details) =>
                        {print(details.globalPosition)},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
