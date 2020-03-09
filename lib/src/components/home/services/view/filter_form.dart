import 'package:flutter/material.dart';
import 'package:stohp/src/models/oversight_filter.dart';
import 'package:stohp/src/models/vehicle_type.dart';
import 'package:stohp/src/values/values.dart';

import 'bloc/oversight_bloc.dart';

class FilterForm extends StatefulWidget {
  final OversightBloc _bloc;

  const FilterForm({Key key, OversightBloc bloc})
      : this._bloc = bloc,
        super(key: key);
  @override
  _FilterFormState createState() => _FilterFormState(_bloc);
}

class _FilterFormState extends State<FilterForm> {
  final OversightBloc bloc;
  final TextEditingController _routeController = TextEditingController();
  String _dropDownValue;

  _FilterFormState(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _routeController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 12.0),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 12.0),
                    labelText: Strings.route,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear, size: 14.0),
                      onPressed: () => _routeController.clear(),
                    ),
                  ),
                ),
                DropdownButtonFormField(
                  isDense: true,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: Strings.vehicleType,
                    labelStyle: TextStyle(fontSize: 12.0),
                  ),
                  value: _dropDownValue,
                  onChanged: (val) {
                    setState(
                      () {
                        _dropDownValue = val;
                      },
                    );
                  },
                  items: VehicleType.getVehicleTypes()
                      .map((VehicleType type) => DropdownMenuItem(
                            child: Text(type.name),
                            value: type.code,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: FlatButton(
              onPressed: () {
                OversightFilter filter = OversightFilter(
                  route: _routeController.text.length == 0
                      ? null
                      : _routeController.text,
                  vehicleType:
                      VehicleType.parseVehicleType(_dropDownValue).name,
                );
                bloc.add(UpdateFilter(filter));
              },
              color: greenPrimary,
              child: Text(
                Strings.filter,
                style: optionButton,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
