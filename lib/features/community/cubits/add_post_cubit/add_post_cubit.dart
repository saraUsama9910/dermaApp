import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../core/commons/functions.dart';
import '../../data/repos/community_repo_implementation.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit({required this.communityRepoImplementation}) : super(AddPostInitial());



  final CommunityRepoImplementation communityRepoImplementation;


  TextEditingController addPostController = TextEditingController();

  XFile? photoFromAddedPost;

  addPhotoForPost({required XFile photo}) async {
    photoFromAddedPost = photo;
    emit(PhotoAddedForPostState());
  }

  deletorPhotoForPost()
  {
    photoFromAddedPost=null;
    emit(PhotoDeltedWhenAddingPostState());
  }

  addPost({String? postText, XFile? postImage}) async {
    emit(AddPostLoadingState());
    final response = await communityRepoImplementation.addPost(
        postText: postText,
        postImage:
        postImage == null ? null : await uploadImageToAPI(postImage));
    response.fold(
          (error) => emit(AddPostFailureState(errorMessage: error)),
          (success) => emit(AddPostSuccessState(successMessage: success)),
    );
  }




}
