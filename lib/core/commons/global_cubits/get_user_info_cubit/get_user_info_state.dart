part of 'get_user_info_cubit.dart';

@immutable
abstract class GetUserInfoState {}

class GetUserInfoInitial extends GetUserInfoState {}


class GetUserDataLoadingState extends GetUserInfoState {}

class GetUserDataSuccessState extends GetUserInfoState {

  final UserAllDataModel userAllDataModel;

  GetUserDataSuccessState({required this.userAllDataModel});
}


class GetUserDataFailureState extends GetUserInfoState {
  final String errorMessage;

  GetUserDataFailureState({required this.errorMessage});
}

