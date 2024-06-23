part of 'update_profile_cubit.dart';

@immutable
abstract class UpdateProfileState {}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoadingState extends UpdateProfileState {}


class UpdateProfileSuccessState extends UpdateProfileState {

  final String successMessage;

  UpdateProfileSuccessState({required this.successMessage});
}


class UpdateProfileFailureState extends UpdateProfileState {

  final String errorMessage;

  UpdateProfileFailureState({required this.errorMessage});
}

class UpdateProfilePhotoState extends UpdateProfileState {}


