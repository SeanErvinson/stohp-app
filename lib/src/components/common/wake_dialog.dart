import 'package:flutter/material.dart';
import 'package:stohp/src/values/values.dart';

import 'bloc/dialog_bloc.dart';

class WakeDialog extends StatelessWidget {
  final DialogBloc _bloc;

  const WakeDialog({Key key, DialogBloc bloc})
      : _bloc = bloc,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
          _bloc.add(HideDialog());
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
