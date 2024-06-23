import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:share_plus/share_plus.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupCubitState> {
  SignupCubit({required this.authRepoImplementation}) : super(SignupInitial());

  final AuthRepoImplementation authRepoImplementation;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  String userTpeSelectedValue = 'user';

  String genderSelectedValue = 'male';

  List<String> genderItems = [
    'male',
    'female',
  ];

  List<String> usersTypes = [
    'user',
    'doctor',
  ];

  IconData signUpPasswordIcon = Icons.visibility_off;
  IconData signUpConfirmPasswordIcon = Icons.visibility_off;

  bool passwordObsecureTextIsActive = true;
  bool passwordConfirmObsecureTextIsActive = true;

  cahangePasswordEye() {
    if (signUpPasswordIcon == Icons.visibility_off) {
      signUpPasswordIcon = Icons.visibility;
      passwordObsecureTextIsActive = false;
      emit(ChangePasswordEyeState());
    } else {
      signUpPasswordIcon = Icons.visibility_off;
      passwordObsecureTextIsActive = true;
      emit(ChangePasswordEyeState());
    }
  }

  changeConfirmPasswordEye() {
    if (signUpConfirmPasswordIcon == Icons.visibility_off) {
      signUpConfirmPasswordIcon = Icons.visibility;
      passwordConfirmObsecureTextIsActive = false;
      emit(ChangeConfirmPasswordEyeState());
    } else {
      signUpConfirmPasswordIcon = Icons.visibility_off;
      passwordConfirmObsecureTextIsActive = true;
      emit(ChangeConfirmPasswordEyeState());
    }
  }

  XFile? uploadedMedicalLisencePhoto;

  uploadMedicalLisencePhoto({required XFile uploadedPhoto}) {
    uploadedMedicalLisencePhoto = uploadedPhoto;
    emit(AddMedicalLisencePhotoForSignUpState());
  }

  deleteMedicalLisencePhoto() {
    uploadedMedicalLisencePhoto = null;
    emit(DeleteMedicalLisencePhoto());
  }

  XFile? updateProfilePic;

  addProfilePic({required XFile profilePic}) {
    updateProfilePic = profilePic;
    emit(AddProfilePhotoForSignUpState());
  }

  signUp(
      {required String name,
      required String email,
      required String displayName,
      required String password,
      required String passwordConfirmation,
      required String gender,
      required String type,
      XFile? profilePic,
      XFile? medicalLisence}) async {
    emit(SignupLoadingState());

    final response = await authRepoImplementation.register(
      name: name,
      email: email,
      displayName: displayName,
      password: password,
      passwordConfirmation: passwordConfirmation,
      gender: gender,
      type: type,
      medicalLisence: medicalLisence != null
          ? await uploadImageToAPI(medicalLisence)
          : null,
      profilePic:
          profilePic != null ? await uploadImageToAPI(profilePic) : null,
    );

    response.fold((error) => emit(SignupFailureState(errorMessage: error)),
        (success) => emit(SignupSuccessState(successMessage: success)));
  }
}
