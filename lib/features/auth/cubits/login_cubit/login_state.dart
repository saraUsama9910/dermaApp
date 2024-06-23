part of 'login_cubit.dart';

@immutable
abstract class LoginCubitState {}

class LoginInitial extends LoginCubitState {}

class LoginLoadingState extends LoginCubitState {}


class LoginFailureState extends LoginCubitState
{

  final String errorMessage;
  LoginFailureState({required this.errorMessage});

}


class LoginSuccessState extends LoginCubitState {

  final LoginModel loginModel;
  LoginSuccessState({required this.loginModel});
}


class changeLoginPasswordEyeState extends LoginCubitState {}





