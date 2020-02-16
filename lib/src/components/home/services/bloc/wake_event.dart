part of 'wake_bloc.dart';

abstract class WakeEvent extends Equatable {
  const WakeEvent();

  @override
  List<Object> get props => [];
}

class CancelTracking extends WakeEvent {}

class StartTracking extends WakeEvent {
  final Place selectedPlace;

  StartTracking(this.selectedPlace);
}

class UpdateTracking extends WakeEvent {
  final Position currentPosition;

  UpdateTracking(this.currentPosition);
}
