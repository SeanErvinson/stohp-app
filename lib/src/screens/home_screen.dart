import 'package:flutter/material.dart';

import 'package:qrscan/qrscan.dart' as scanner;
import 'package:qr_flutter/qr_flutter.dart';

import '../values/values.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String barcode = '';
  final TextEditingController destinationInputController =
      TextEditingController();
  var topVisible = false;
  var bottomVisible = true;

  void changeVisibility() {
    setState(() {
      topVisible = !topVisible;
      bottomVisible = !bottomVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;
    var initial = 0.0;
    var distance = 0.0;
    return SafeArea(
      child: GestureDetector(
        onPanStart: (DragStartDetails details) {
          initial = details.globalPosition.dx;
        },
        onPanUpdate: (DragUpdateDetails details) {
          distance = details.globalPosition.dx - initial;
        },
        onPanEnd: (DragEndDetails details) {
          initial = 0.0;
          if (distance < -100) _scan();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              Visibility(
                visible: topVisible,
                child: Container(
                  color: Colors.red,
                  height: 300.0,
                ),
              ),
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
                            paste: true,
                            copy: true,
                            cut: true,
                            selectAll: true),
                        style: TextStyle(),
                      ),
                    ),
                    // QrImage(
                    //   data: "1234567890",
                    //   version: QrVersions.auto,
                    //   size: 160.0,
                    //   gapless: false,
                    //   embeddedImage: AssetImage('assets/logo/logo.png'),
                    //   embeddedImageStyle: QrEmbeddedImageStyle(
                    //     size: Size(24, 24),
                    //   ),
                    //   errorStateBuilder: (cxt, err) {
                    //     return Container(
                    //       child: Center(
                    //         child: Text(
                    //           "Uh oh! Something went wrong...",
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                    FlatButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: 80.0, vertical: 12.0),
                      textColor: Colors.white,
                      child: Text(
                        Strings.start,
                        style: Theme.of(context).textTheme.button,
                      ),
                      color: Color.fromRGBO(0, 177, 79, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      onPressed: () {
                        changeVisibility();
                        print(destinationInputController.text);
                      },
                    )
                  ],
                ),
              ),
              Visibility(
                visible: bottomVisible,
                child: GestureDetector(
                  onVerticalDragUpdate: (DragUpdateDetails details) =>
                      print(details.globalPosition),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(48.0),
                        topRight: Radius.circular(48.0),
                      ),
                      color: Color.fromRGBO(240, 240, 240, 1),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 24.0, horizontal: 48.0),
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    setState(() => destinationInputController.text = barcode);
  }

  @override
  void dispose() {
    destinationInputController.dispose();
    super.dispose();
  }
}
