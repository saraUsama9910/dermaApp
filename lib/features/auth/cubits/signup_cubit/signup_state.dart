part of 'signup_cubit.dart';

@immutable
abstract class SignupCubitState {}

class SignupInitial extends SignupCubitState {}

class SignupLoadingState extends SignupCubitState {}

class SignupFailureState extends SignupCubitState {
  final String errorMessage;

  SignupFailureState({required this.errorMessage});
}

class SignupSuccessState extends SignupCubitState {
  final String successMessage;

  SignupSuccessState({required this.successMessage});
}

class AddProfilePhotoForSignUpState extends SignupCubitState {}

class AddMedicalLisencePhotoForSignUpState extends SignupCubitState {}

class ChangePasswordEyeState extends SignupCubitState {}

class ChangeConfirmPasswordEyeState extends SignupCubitState {}

class DeleteMedicalLisencePhoto extends SignupCubitState {}
