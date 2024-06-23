import 'package:bloc/bloc.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/features/profile/data/repos/profile_repo_implementation.dart';
import 'package:meta/meta.dart';

part 'delete_user_state.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  DeleteUserCubit({required this.profileRepoImplementation}) : super(DeleteUserInitial());

  ProfileRepoImplementation profileRepoImplementation;

  deleteAccountFun() async
  {
    emit(DeleteAccountLoadingState());
    final response=await profileRepoImplementation.deleteUser(
        userId: CacheHelper().getData(key: ApiKeys.id),
        token: CacheHelper().getData(key: ApiKeys.token));

    response.fold(
            (error) => emit(DeleteAccountFailureState(errorMessage: error)),
            (success) => emit(DeleteAccountSuccessState(successMessage: success)));


  }


}
