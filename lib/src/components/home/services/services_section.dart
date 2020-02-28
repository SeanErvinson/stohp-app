import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stohp/src/components/common/card_header.dart';
import 'package:stohp/src/components/common/stohp_icons.dart';
import 'package:stohp/src/components/home/services/bloc/wake_bloc.dart';
import 'package:stohp/src/values/values.dart';

import 'bloc/stop_bloc.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      semanticContainer: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CardHeader(
              title: Strings.servicesHeader,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                BlocBuilder<WakeBloc, WakeState>(
                  builder: (context, state) {
                    VoidCallback onClick;
                    if (state is WakeRunning)
                      onClick = () => _onConfirmationDialog(context);
                    else
                      onClick = () => Navigator.of(context)
                          .pushNamed("location-destination");
                    return ServiceButton(
                      title: Strings.wakeService,
                      icon: Icons.alarm,
                      onPressed: onClick,
                    );
                  },
                ),
                BlocListener<StopBloc, StopState>(
                  listener: (context, state) {
                    if (state is StopScanFailed) {
                      Scaffold.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Container(
                              height:
                                  MediaQuery.of(context).size.height * .02,
                              child: Text(
                                Strings.scanError,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                    }
                  },
                  child: BlocBuilder<StopBloc, StopState>(
                    builder: (context, state) {
                      String label;
                      IconData icon;
                      Color backgroundColor;
                      VoidCallback onPressed;
                      VoidCallback onLongPressed;
                      if (state is StopQRCaptured) {
                        label = Strings.stopService;
                        backgroundColor = redPrimary;
                        onLongPressed = () =>
                            BlocProvider.of<StopBloc>(context)
                                .add(CancelStop());
                        onPressed = () => BlocProvider.of<StopBloc>(context)
                            .add(SendStopRequest(state.qrCode));
                        icon = Stohp.block;
                      } else {
                        label = Strings.scanService;
                        onPressed = () => BlocProvider.of<StopBloc>(context)
                            .add(ScanQREvent());
                        icon = Stohp.scan;
                      }
                      return ServiceButton(
                        title: label,
                        icon: icon,
                        onPressed: onPressed,
                        onLongPressed: onLongPressed,
                        color: backgroundColor,
                      );
                    },
                  ),
                ),
                ServiceButton(
                  title: Strings.mapService,
                  icon: Stohp.map_signs,
                  onPressed: () => Navigator.pushNamed(context, "navigation"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _onConfirmationDialog(BuildContext context) {
    final WakeBloc _bloc = BlocProvider.of<WakeBloc>(context);
    Alert(
      context: context,
      type: AlertType.warning,
      title: Strings.cancelTripTitle,
      desc: Strings.cancelTripDesc,
      buttons: [
        DialogButton(
            child: Text(
              Strings.yesOption,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              _bloc.add(CancelTracking());
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed("location-destination");
            }),
        DialogButton(
          child: Text(
            Strings.noOption,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ).show();
  }
}

class ServiceButton extends StatelessWidget {
  final String _title;
  final VoidCallback _onPressed;
  final VoidCallback _onLongPressed;
  final IconData _icon;
  final Color _color;

  const ServiceButton({
    Key key,
    String title,
    VoidCallback onPressed,
    VoidCallback onLongPressed,
    IconData icon,
    Color color,
  })  : this._title = title,
        this._onPressed = onPressed,
        this._icon = icon,
        this._onLongPressed = onLongPressed ?? null,
        this._color = color ?? darkBlue,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MaterialButton(
          padding: EdgeInsets.all(14),
          shape: CircleBorder(),
          onPressed: _onPressed,
          onLongPress: _onLongPressed,
          color: _color,
          child: Icon(
            _icon,
            color: Colors.white,
            size: 28,
          ),
        ),
        Text(_title)
      ],
    );
  }
}
