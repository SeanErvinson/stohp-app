import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/common/bloc/greet_bloc.dart';
import 'package:stohp/src/components/profile/profile_screen_argument.dart';
import 'package:stohp/src/models/user.dart';
import 'package:stohp/src/services/api_service.dart';
import 'package:stohp/src/values/values.dart';

class GreetingHeader extends StatelessWidget {
  final User _user;
  static const String _defaultProfilePic =
      "assets/images/default-profile-pic.png";

  const GreetingHeader({Key key, User user})
      : _user = user,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final _usableScreenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _usableScreenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<GreetBloc, GreetState>(
      builder: (context, state) {
        String greetings = Strings.greetingsDefault;
        String assetLeft;
        String assetRight;
        Color topRightColor = Colors.white;
        Color botLeftColor = Colors.white;
        if (state is GreetMorning) {
          greetings = Strings.greetingsMorning;
          assetLeft = 'assets/images/morning-left.png';
          assetRight = 'assets/images/morning-right.png';
          topRightColor = darkBlue;
          botLeftColor = lightBlue;
        } else if (state is GreetAfternoon) {
          greetings = Strings.greetingsAfternoon;
          assetLeft = 'assets/images/afternoon-left.png';
          assetRight = 'assets/images/afternoon-right.png';
          topRightColor = darkOrange;
          botLeftColor = lightOrange;
        } else if (state is GreetEvening) {
          greetings = Strings.greetingsEvening;
          assetLeft = 'assets/images/evening-left.png';
          assetRight = 'assets/images/evening-right.png';
          topRightColor = eveningColor;
          botLeftColor = darkEveningPurple;
        }
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [botLeftColor, topRightColor])),
          height: _usableScreenHeight * .1,
          width: _usableScreenWidth,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: greetings,
                    style: Theme.of(context).textTheme.subtitle,
                    children: [
                      TextSpan(
                        text: _user.firstName,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  width: 64,
                  height: 64,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(assetLeft))),
                  )),
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(assetRight),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => Navigator.of(context).pushNamed("profile",
                      arguments: UserArgument(user: _user)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 18.0,
                      backgroundImage: _user.profile.avatar != null
                          ? NetworkImage(
                              ApiService.baseUrl + _user.profile.avatar)
                          : AssetImage(_defaultProfilePic),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      bloc: BlocProvider.of<GreetBloc>(context),
    );
  }
}
