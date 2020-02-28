import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'greet_event.dart';
part 'greet_state.dart';

class GreetBloc extends Bloc<GreetEvent, GreetState> {
  @override
  GreetState get initialState => GreetInitial();

  @override
  Stream<GreetState> mapEventToState(
    GreetEvent event,
  ) async* {
    if (event is GetGreetings) {
      yield* _mapAppStarted();
    }
  }

  Stream<GreetState> _mapAppStarted() async* {
    int hour = DateTime.now().hour;
    if (hour >= 0 && hour < 12) {
      yield GreetMorning();
    } else if (hour >= 12 && hour > 18) {
      yield GreetAfternoon();
    } else {
      yield GreetEvening();
    }
  }
}
