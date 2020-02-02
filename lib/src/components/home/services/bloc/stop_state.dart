part of 'stop_bloc.dart';

abstract class StopState extends Equatable {
  const StopState();

  @override
  List<Object> get props => [];
}

class StopInitial extends StopState {}

class StopQRCaptured extends StopState {
  final String qrCode;

  StopQRCaptured(this.qrCode);
}

class StopScanFailed extends StopState {}

class DisableStop extends StopState {
  final bool isDisabled;

  DisableStop(this.isDisabled);
}
