import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  final String _title;
  final IconData _icon;
  final VoidCallback _onPressed;
  final Color _iconColor;

  const ProfileListTile(
      {Key key,
      String title,
      IconData icon,
      VoidCallback onPressed,
      Color iconColor})
      : this._title = title,
        this._icon = icon,
        this._onPressed = onPressed,
        this._iconColor = iconColor ?? Colors.black87,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: Text(_title),
      trailing: Icon(
        _icon,
        size: 20,
        color: _iconColor,
      ),
      onTap: _onPressed,
    );
  }
}
