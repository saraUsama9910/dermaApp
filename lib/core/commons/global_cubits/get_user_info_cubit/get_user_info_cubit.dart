import 'package:bloc/bloc.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/features/profile/data/models/get_user_data_model/user_all_data_model.dart';
import 'package:graduation/features/profile/data/models/profile_items_model/profile_item_model.dart';
import 'package:graduation/features/profile/data/repos/profile_repo_implementation.dart';
import 'package:meta/meta.dart';

part 'get_user_info_state.dart';

class GetUserInfoCubit extends Cubit<GetUserInfoState> {
  GetUserInfoCubit({required this.profileRepoImplementation}) : super(GetUserInfoInitial());

  ProfileRepoImplementation profileRepoImplementation;


  getUserData() async
  {
    emit(GetUserDataLoadingState());
   final response=await profileRepoImplementation.getUserData(
        userId:CacheHelper().getData(key: ApiKeys.id)
    );

   response.fold(
       (error) => emit(GetUserDataFailureState(errorMessage: error)),
       (success) => emit(GetUserDataSuccessState(userAllDataModel: success)));
  }


  List<ProfileItemModel>profileItems =
  [
    ProfileItemModel(title: 'Edit Profile', image: ImageConstants.userProfileIcon),
    ProfileItemModel(title: 'Language', image: ImageConstants.languageProfileIcon),
    ProfileItemModel(title: 'Notifications', image: ImageConstants.notificationsProfileIcon),
    ProfileItemModel(title: 'Share App', image: ImageConstants.shareAppIcon),
    ProfileItemModel(title: 'FAQ', image: ImageConstants.faqProfileIcon),
    ProfileItemModel(title: 'Medical Record', image: ImageConstants.medicalRecordIcon),
    ProfileItemModel(title: 'Logout', image: ImageConstants.logoutProfileIcon),
  ];




}
