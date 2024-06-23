import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation/features/auth/data/repos/auth_repo_implementation.dart';

part 'forgot_pass_state.dart';

class ForgotPassCubit extends Cubit<ForgotPassCubitState> {
  ForgotPassCubit({required this.authRepoImplementation})
      : super(ForgotPassInitial());

  final AuthRepoImplementation authRepoImplementation;

  GlobalKey<FormState> forgetPassFormKey = GlobalKey<FormState>();

  TextEditingController forgetPassEmailController = TextEditingController();

  forgotPass({required String email}) async {
    final response = await authRepoImplementation.forgotPassword(email: email);

    response.fold((error) => emit(ForgotPassFailureState(errorMessage: error)),
        (success) => emit(ForgotPassSuccessState(successMessage: success)));
  }
}
