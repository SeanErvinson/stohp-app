import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:stohp/src/values/values.dart';

class WelcomeScreen extends StatelessWidget {
  static const String _backgroundImage = "assets/images/background.jpg";
  static const String _foregroundImage =
      "assets/icons/logo-banner-foreground.png";

  @override
  Widget build(BuildContext context) {
    final _usableScreenHeight = MediaQuery.of(context).size.height;
    final _usableScreenWidth = MediaQuery.of(context).size.width;
    final _logoSize = 192.0;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                child: Image.asset(_foregroundImage, width: _logoSize),
                top: _usableScreenHeight * .1,
                left: (_usableScreenWidth * .5) - (_logoSize * .5)),
            Positioned(
              width: _usableScreenWidth,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(
                            flex: 1,
                            child: FadeIn(
                              2,
                              CredentialButton(
                                title: Strings.login,
                                onPressed: () =>
                                    Navigator.pushNamed(context, "login"),
                              ),
                            )),
                        SizedBox(
                          width: 32.0,
                        ),
                        Flexible(
                            flex: 1,
                            child: FadeIn(
                              2.5,
                              CredentialButton(
                                title: Strings.register,
                                onPressed: () => Navigator.pushNamed(
                                    context, "registration"),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FadeIn extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeIn(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 500), Tween(begin: 24.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}

class CredentialButton extends StatelessWidget {
  final String _title;
  final VoidCallback _onPressed;

  const CredentialButton({Key key, String title, VoidCallback onPressed})
      : this._onPressed = onPressed,
        this._title = title,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          color: Color.fromRGBO(40, 40, 40, .70),
          child: Text(
            _title,
            textAlign: TextAlign.center,
            style: navigationTitle,
          ),
          onPressed: _onPressed),
    );
  }
}
