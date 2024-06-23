import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/features/profile/data/repos/profile_repo_implementation.dart';
import 'package:meta/meta.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordCubitStates> {
  UpdatePasswordCubit({required this.profileRepoImplementation}) : super(UpdatePasswordInitialState());

  ProfileRepoImplementation profileRepoImplementation;

  TextEditingController oldPasswordController=TextEditingController();
  TextEditingController newPasswordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();


  IconData oldPasswordIcon=Icons.visibility_off;
  IconData newPasswordIcon=Icons.visibility_off;
  IconData confirmNewPasswordIcon=Icons.visibility_off;

  bool oldPasswordObscure=true;
  bool newPasswordObscure=true;
  bool confirmNewPasswordObscure=true;

  updateOldPasswordIcon()
  {
    if(oldPasswordIcon==Icons.visibility)
    {
      oldPasswordIcon=Icons.visibility_off;
      oldPasswordObscure=true;

    }
    else
    {
      oldPasswordIcon=Icons.visibility;
      oldPasswordObscure=false;

    }
    emit(UpdateOldPasswordIconState());
  }

  updateNewPasswordIcon()
  {
    if(newPasswordIcon==Icons.visibility)
    {
      newPasswordIcon=Icons.visibility_off;
      newPasswordObscure=true;
    }
    else
    {
      newPasswordIcon=Icons.visibility;
      newPasswordObscure=false;

    }
    emit(UpdateNewPasswordIconState());
  }

  updateConfirmNewPasswordIcon()
  {
    if(confirmNewPasswordIcon==Icons.visibility)
    {
      confirmNewPasswordIcon=Icons.visibility_off;
      confirmNewPasswordObscure=true;

    }
    else
    {
      confirmNewPasswordIcon=Icons.visibility;
      confirmNewPasswordObscure=false;

    }
    emit(UpdateConfirmNewPasswordIconState());
  }


  GlobalKey<FormState> updatePasswordFormKey=GlobalKey<FormState>();
  changePassword({required String oldPassword,required String newPassword,required String confirmNewPassword}) async
  {
    emit(UpdatePasswordLoadingState());

    final response=await profileRepoImplementation.changePassword(
        userId: CacheHelper().getData(key: ApiKeys.id),
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword);
    response.fold(
        (error) => emit(UpdatePasswordFailureState(errorMessage: error)),
        (success) => emit(UpdatePasswordSuccessState(successMessage: success)));
  }

}
