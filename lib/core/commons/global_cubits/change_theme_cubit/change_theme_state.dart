part of 'change_theme_cubit.dart';

@immutable
abstract class ChangeThemeState {}

class ChangeThemeInitial extends ChangeThemeState {}


class ChangeThemeSuccessState extends ChangeThemeState {


  final String successMessage;

  ChangeThemeSuccessState({required this.successMessage});
}

class ChangeThemeCurrentActiveState extends ChangeThemeState {}

