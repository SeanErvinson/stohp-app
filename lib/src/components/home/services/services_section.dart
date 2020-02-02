import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stohp/src/components/common/card_header.dart';
import 'package:stohp/src/components/home/services/bloc/location_track_bloc.dart';
import 'package:stohp/src/values/values.dart';

import 'bloc/stop_bloc.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
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
                  BlocBuilder<LocationTrackBloc, LocationTrackState>(
                    builder: (context, state) {
                      VoidCallback onClick;
                      if (state is LocationRunning)
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
                        if (state is StopQRCaptured) {
                          return StopButton(qrCode: state.qrCode);
                        }
                        return ServiceButton(
                          title: Strings.scanService,
                          icon: Icons.pause,
                          onPressed: () => BlocProvider.of<StopBloc>(context)
                              .add(ScanQREvent()),
                        );
                      },
                    ),
                  ),
                  ServiceButton(
                    title: Strings.mapService,
                    icon: Icons.map,
                    onPressed: () => Navigator.pushNamed(context, "navigation"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onConfirmationDialog(BuildContext context) {
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
              // Cancel current trip
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

class StopButton extends StatelessWidget {
  final String _qrCode;
  const StopButton({Key key, String qrCode})
      : this._qrCode = qrCode,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final StopBloc _bloc = BlocProvider.of<StopBloc>(context);
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () => _bloc.add(SendStopRequest(_qrCode)),
          onLongPress: () => _bloc.add(CancelStop()),
          child: CircleAvatar(
            backgroundColor: redPrimary,
            foregroundColor: Colors.white,
            child: const Icon(Icons.stop, size: 24.0),
          ),
        ),
        Text(Strings.stopService)
      ],
    );
  }
}

class ServiceButton extends StatelessWidget {
  final String _title;
  final VoidCallback _onPressed;
  final IconData _icon;

  const ServiceButton({
    Key key,
    String title,
    VoidCallback onPressed,
    IconData icon,
  })  : this._title = title,
        this._onPressed = onPressed,
        this._icon = icon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: darkBlue,
          foregroundColor: Colors.white,
          child: IconButton(
            icon: Icon(_icon),
            iconSize: 24.0,
            onPressed: _onPressed,
          ),
        ),
        Text(_title)
      ],
    );
  }
}
