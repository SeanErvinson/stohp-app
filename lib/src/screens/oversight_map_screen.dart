import 'package:flutter/material.dart';
import 'package:stohp/src/components/home/services/view/bloc/oversight_bloc.dart';
import 'package:stohp/src/components/home/services/view/filter_form.dart';
import 'package:stohp/src/components/home/services/view/oversight_map.dart';
import 'package:stohp/src/components/profile/profile_screen_argument.dart';
import 'package:stohp/src/models/commuter_oversight_info.dart';
import 'package:stohp/src/models/user.dart';
import 'package:stohp/src/values/values.dart';

class OversightMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _usableScreenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _usableScreenWidth = MediaQuery.of(context).size.width;
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
            Positioned(
              width: _usableScreenWidth,
              child: Container(
                height: _usableScreenHeight * .3,
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(8.0),
                  child: FilterForm(
                    bloc: _oversightBloc,
                  ),
                ),
              ),
              bottom: 0,
            ),
          ],
        ),
      ),
    );
  }
}
