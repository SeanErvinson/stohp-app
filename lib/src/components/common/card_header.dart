import 'package:flutter/material.dart';
import 'package:stohp/src/values/values.dart';

class CardHeader extends StatelessWidget {
  final String _title;

  const CardHeader({Key key, String title})
      : this._title = title,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8),
      child: Text(_title, style: cardHeader),
    );
  }
}
