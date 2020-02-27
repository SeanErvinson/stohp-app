import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:stohp/src/repository/user_repository.dart';
import 'package:stohp/src/services/api_service.dart';
import 'package:web_socket_channel/io.dart';

part 'stop_event.dart';
part 'stop_state.dart';

class StopBloc extends Bloc<StopEvent, StopState> {
  final UserRepository _userRepository;
  IOWebSocketChannel _socket;
  StreamSubscription _wsSubscription;

  StopBloc(UserRepository userRepository) : _userRepository = userRepository;

  @override
  StopState get initialState => StopInitial();

  @override
  Future<void> close() {
    _wsSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<StopState> mapEventToState(
    StopEvent event,
  ) async* {
    if (event is ScanQREvent) {
      yield* _mapScanQR();
    } else if (event is CancelStop) {
      yield* _mapCancelStop();
    } else if (event is SendStopRequest) {
      yield* _mapSendStopRequest(event.qrCode);
    }
  }

  Stream<StopState> _mapSendStopRequest(String qrCode) async* {
    _socket.sink.add(jsonEncode({'stop': true}));
    _closeSockets();
    yield DisableStop(true);
  }

  Stream<StopState> _mapCancelStop() async* {
    _closeSockets();
    yield StopInitial();
  }

  Stream<StopState> _mapScanQR() async* {
    String result = await scanner.scan();
    if (result == null) yield StopInitial();
    if (await _userRepository.verifyStopCode(result)) {
      _socket = IOWebSocketChannel.connect(
          '${ApiService.baseWsUrl}/ws/stop/$result/');
      yield StopQRCaptured(result);
    } else {
      yield StopScanFailed();
    }
  }

  void _closeSockets() {
    _socket.sink.close();
    _wsSubscription?.cancel();
  }
}
