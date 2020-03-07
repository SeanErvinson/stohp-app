import 'package:flutter/material.dart';
import 'package:stohp/src/components/home/services/view/bloc/oversight_bloc.dart';
import 'package:stohp/src/components/home/services/view/oversight_map.dart';
import 'package:stohp/src/components/profile/profile_screen_argument.dart';
import 'package:stohp/src/models/commuter_oversight_info.dart';
import 'package:stohp/src/models/user.dart';
import 'package:stohp/src/values/values.dart';

class OversightMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserArgument args = ModalRoute.of(context).settings.arguments;
    final User user = args.user;
    final OversightBloc _oversightBloc =
        OversightBloc(CommuterOversightInfo(id: user.id));
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            OversightMap(bloc: _oversightBloc),
            Positioned(
              top: 10,
              left: 10,
              child: FloatingActionButton.extended(
                onPressed: () {
                  _oversightBloc.add(DisconnectRoom());
                  Navigator.of(context).pop();
                },
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
