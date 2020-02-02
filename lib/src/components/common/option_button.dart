import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stohp/src/values/values.dart';

class OptionButton extends DialogButton {
  final String _title;
  final Color _color;
  final VoidCallback _onPressed;

  OptionButton({Key key, String title, Color color, VoidCallback onPressed})
      : this._title = title,
        this._color = color,
        this._onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return DialogButton(
      radius: BorderRadius.all(Radius.circular(0)),
      color: _color,
      child: Text(
        _title,
        style: optionButton,
      ),
      onPressed: _onPressed,
      width: 120,
    );
  }
}
