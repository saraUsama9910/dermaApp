part of 'delete_user_cubit.dart';

@immutable
abstract class DeleteUserState {}

class DeleteUserInitial extends DeleteUserState {}

class DeleteAccountLoadingState extends DeleteUserState {}


class DeleteAccountFailureState extends DeleteUserState {

  final String errorMessage;

  DeleteAccountFailureState({required this.errorMessage});

}


class DeleteAccountSuccessState extends DeleteUserState {

  final String successMessage;

  DeleteAccountSuccessState({required this.successMessage});
}

