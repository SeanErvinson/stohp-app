import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/home/services/bloc/wake_bloc.dart';
import 'package:stohp/src/values/values.dart';

import 'bloc/dialog_bloc.dart';

class WakeDialog extends StatelessWidget {
  const WakeDialog({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final WakeBloc _wakeBloc = BlocProvider.of<WakeBloc>(context);
    final DialogBloc _dialogBloc = BlocProvider.of<DialogBloc>(context);
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
          _dialogBloc.add(HideDialog());
          _wakeBloc.add(CancelTracking());
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: bluePrimary,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.info,
                color: Colors.white,
                size: 56.0,
              ),
              SizedBox(height: 16.0),
              Flexible(
                  flex: 1,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: Strings.wakeDialogInstruction1,
                      style: subtitle.copyWith(
                          fontSize: 32.0, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: Strings.wakeDialogInstruction2,
                          style: subtitle.copyWith(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  )),
              SizedBox(height: 16.0),
              Text(
                Strings.wakeDialogInstruction3,
                style: subtitle.copyWith(fontSize: 10.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
