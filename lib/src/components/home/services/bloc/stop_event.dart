part of 'stop_bloc.dart';

abstract class StopEvent extends Equatable {
  const StopEvent();
  @override
  List<Object> get props => null;
}

class ScanQREvent extends StopEvent {}

class CancelStop extends StopEvent {}

class SendStopRequest extends StopEvent {
  final String qrCode;

  const SendStopRequest(this.qrCode);
}
