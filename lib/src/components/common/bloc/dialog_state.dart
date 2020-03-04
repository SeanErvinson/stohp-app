part of 'dialog_bloc.dart';

@immutable
abstract class DialogState {}

class InitialDialogState extends DialogState {}

class DialogHidden extends DialogState {}

class DialogVisible extends DialogState {}