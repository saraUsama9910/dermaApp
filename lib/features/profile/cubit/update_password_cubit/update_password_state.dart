part of 'update_password__cubit.dart';

@immutable
abstract class UpdatePasswordCubitStates {}

class UpdatePasswordInitialState extends UpdatePasswordCubitStates {}


class UpdateOldPasswordIconState extends UpdatePasswordCubitStates {}

class UpdateNewPasswordIconState extends UpdatePasswordCubitStates {}

class UpdateConfirmNewPasswordIconState extends UpdatePasswordCubitStates {}




class UpdatePasswordLoadingState extends UpdatePasswordCubitStates {}


class UpdatePasswordSuccessState extends UpdatePasswordCubitStates {
  final String successMessage;

  UpdatePasswordSuccessState({required this.successMessage});
}



class UpdatePasswordFailureState extends UpdatePasswordCubitStates {

  final String errorMessage;

  UpdatePasswordFailureState({required this.errorMessage});
}

