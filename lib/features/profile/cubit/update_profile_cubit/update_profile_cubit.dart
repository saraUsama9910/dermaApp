import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/features/profile/data/repos/profile_repo_implementation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:share_plus/share_plus.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit({required this.profileRepoImplementation}) : super(UpdateProfileInitial());

  final ProfileRepoImplementation profileRepoImplementation;


  XFile? updateProfilePhoto;

  updateProfilePhotoFun({required XFile image})
  {
    updateProfilePhoto=image;
    emit(UpdateProfilePhotoState());

  }



  TextEditingController updateNameController=TextEditingController();
  TextEditingController updateEmailController=TextEditingController();
  TextEditingController updateDisplayNameController=TextEditingController();

  GlobalKey<FormState> updateProfileFormKey=GlobalKey<FormState>();

  updateProfile({required String name, required String email,required String display_name,MultipartFile? profilePhoto}) async
  {
    emit(UpdateProfileLoadingState());
    final response=await profileRepoImplementation.updateProfile(userId: CacheHelper().getData(key: ApiKeys.id),
    name: name,
    email:  email,
    display_name: display_name,
    profilePhoto: updateProfilePhoto!=null? await uploadImageToAPI(updateProfilePhoto!):null
  ) ;

    response.fold((error) {
      emit(UpdateProfileFailureState(errorMessage: error));
    }, (success) {
      emit(UpdateProfileSuccessState(successMessage: success));
    });


  }

}
