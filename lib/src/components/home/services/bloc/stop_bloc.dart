import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qrscan/qrscan.dart' as scanner;

part 'stop_event.dart';
part 'stop_state.dart';

class StopBloc extends Bloc<StopEvent, StopState> {
  @override
  StopState get initialState => StopInitial();

  @override
  Stream<StopState> mapEventToState(
    StopEvent event,
  ) async* {
    if (event is ScanQREvent) {
      yield* _mapScanQR();
    }
    if (event is CancelStop) {
      yield* _mapCancelStop();
    }
    if (event is SendStopRequest) {
      yield* _mapSendStopRequest(event.qrCode);
    }
  }
}

Stream<StopState> _mapSendStopRequest(String qrCode) async* {
  // Sends request to server
  yield DisableStop(true);
}

Stream<StopState> _mapCancelStop() async* {
  yield StopInitial();
}

Stream<StopState> _mapScanQR() async* {
  String result = await scanner.scan();
  if (result == null) yield StopInitial();
  if (result.length > 10) yield StopScanFailed();
  else yield StopQRCaptured(result);
}
