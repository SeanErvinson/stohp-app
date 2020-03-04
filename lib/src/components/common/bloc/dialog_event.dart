part of 'dialog_bloc.dart';

@immutable
abstract class DialogEvent {}

class ShowDialog extends DialogEvent {}

class HideDialog extends DialogEvent {}
