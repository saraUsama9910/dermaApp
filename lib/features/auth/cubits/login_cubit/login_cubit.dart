import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation/features/auth/data/models/login_model/LoginModel.dart';
import 'package:graduation/features/auth/data/repos/auth_repo_implementation.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit({required this.authRepoImplementation}) : super(LoginInitial());

  final AuthRepoImplementation authRepoImplementation;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  IconData passwordSuffiXIcon = Icons.visibility_off;

  bool passwordObsecureText = true;

  changePasswordEye() {
    if (passwordSuffiXIcon == Icons.visibility_off) {
      passwordSuffiXIcon = Icons.visibility;
      passwordObsecureText = false;
      emit(changeLoginPasswordEyeState());
    } else {
      passwordSuffiXIcon = Icons.visibility_off;
      passwordObsecureText = true;
      emit(changeLoginPasswordEyeState());
    }
  }

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  login({required String email, required String password}) async {
    emit(LoginLoadingState());
    final response =
        await authRepoImplementation.login(email: email, password: password);

    response.fold((error) => emit(LoginFailureState(errorMessage: error)),
        (success) => emit(LoginSuccessState(loginModel: success)));
  }
}
