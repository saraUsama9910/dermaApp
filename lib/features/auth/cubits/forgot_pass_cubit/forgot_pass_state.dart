part of 'forgot_pass_cubit.dart';

@immutable
abstract class ForgotPassCubitState {}

class ForgotPassInitial extends ForgotPassCubitState {}


class ForgotPassLoadingState extends ForgotPassCubitState {}
class ForgotPassSuccessState extends ForgotPassCubitState {

  final String successMessage;

  ForgotPassSuccessState({required this.successMessage});


}
class ForgotPassFailureState extends ForgotPassCubitState {

  final String errorMessage;

  ForgotPassFailureState({required this.errorMessage});


}
