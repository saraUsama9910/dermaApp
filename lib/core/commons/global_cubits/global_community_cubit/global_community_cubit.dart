import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/features/community/data/models/comments_model/comments_model.dart';
import 'package:graduation/features/community/data/models/get_all_posts_model/AllPostsModel.dart';
import 'package:graduation/features/community/data/models/one_post_model/one_post_model.dart';
import 'package:graduation/features/community/data/models/search_model/search_model.dart';
import 'package:graduation/features/community/data/repos/community_repo_implementation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

part 'global_community_state.dart';

class GlobalCommunityCubit extends Cubit<GlobalCommunityState> {
  GlobalCommunityCubit({required this.communityRepoImplementation})
      : super(GlobalCommunityInitial());

  final CommunityRepoImplementation communityRepoImplementation;


  //get all posts
  AllPostsModel? getAllPostsModel;
  getAllPosts() async {
    emit(GetAllPostsLoadingState());

    final response = await communityRepoImplementation.getAllPosts(
        token: CacheHelper().getData(key: ApiKeys.token));

    response.fold((error) {
      getAllPostsModel = null;
      emit(GetAllPostsFailureState(errorMessage: error));
    }, (success) {
      getAllPostsModel = success;
      emit(GetAllPostsSuccessState(getAllPostsModel: success));
    });
  }


  //add like
  addLikeForPost({required num postId}) async {
    final response =
        await communityRepoImplementation.upvatePost(postId: postId);

  }



  //add dislike
  addDislikeForPost({required num postId}) async {

    final response =
        await communityRepoImplementation.downvatePost(postId: postId);

  }





  //add comment
  getNumOfComments({required num postsNum}) {
    return postsNum;
  }

  getCommentsForPost({required num postId}) async {
    emit(GetAllCommentsLoadingState());

    final response =
        await communityRepoImplementation.getCommnetsOnPost(postId: postId);

    var commentsNum = getNumOfComments(postsNum: response.data!.length);

    if (commentsNum == 0) {
      emit(GetAllCommentsFailureState());
    } else {
      emit(GetAllCommentsSuccessState(commentsModel: response));
      return response;
    }
  }

  TextEditingController addCommentControllerForAddScreen = TextEditingController();
  TextEditingController addCommentControllerForPostDetailsScreen =
      TextEditingController();

  addCommentForPost({required num postId, required String comment}) async {
    emit(AddCommentLoadingState());

    final response = await communityRepoImplementation.addComment(
        postId: postId, comment: comment);

    response.fold(
      (error) => emit(AddCommentFailureState(errorMessage: error)),
      (success) => emit(AddCommentSuccessState(successMessage: success)),
    );
  }

  //delete post
  deletePost({required num postId}) async {

    final response =
    await communityRepoImplementation.deletePost(postId: postId);

  }




  // update post
  XFile? updatedPostImage;

  updateNewImageForPost({required XFile image})
  {
    updatedPostImage = image;
    emit(PhotoUpdatedForPostState());
  }

  deleteUpdatePostImage() async {
    updatedPostImage = null;
    emit(PhotoDeletedForEditPostState());
  }

  deleteMainUpdatedmage()
  {
    updatedPostImage = null;
    emit(DeletedMainUpdatedPostImage());
  }

  TextEditingController textFieldForUpdatedTextController = TextEditingController();
  updatePost({required num postId, String? postText, XFile? attachment}) async {
    emit(UpdatePostLoadingState());

    final response = await communityRepoImplementation.updatePost(
        postId: postId,
        postText: postText,
        attachment: updatedPostImage != null
            ? await uploadImageToAPI(updatedPostImage!)
            : null);

    response.fold(
      (error) => emit(UpdatePostFailureState(errorMessage: error)),
      (success) => emit(UpdatePostSuccessState(successMessage: success)),
    );
  }


  //update comment
  TextEditingController updateCommentController = TextEditingController();
  TextEditingController updateCommentControllerForPostDetailsScreen =
      TextEditingController();
  updateComment({required String newContent, required num commentId}) async {
    final response = await communityRepoImplementation.updateComment(
        newContent: newContent, commentId: commentId);

  }


  //delete comment
  deleteComment({required num commentId}) async {

    final response = await communityRepoImplementation.deleteComment(commentId: commentId);

  }

  //get upvotes num
  getUpvotesNumber({required num postId}) async {
    emit(GetUpvotesNumLoadingState());

    final response =
        await communityRepoImplementation.getUpvotesNumber(postId: postId);

    response.fold(
      (error) => emit(GetUpvotesNumFailureState(errorMessage: error)),
      (success) => emit(GetUpvotesNumSuccessState(upvotesNum: success)),
    );
  }

  //get downvotes num
  getDownVotesNumber({required num postId}) async {
    emit(GetDownvotesNumLoadingState());

    final response =
        await communityRepoImplementation.getUpvotesNumber(postId: postId);

    response.fold(
      (error) => emit(GetDownvotesNumFailureState(errorMessage: error)),
      (success) => emit(GetDownvotesNumSuccessState(downvotesNum: success)),
    );
  }


  //get comments num
  getCommentsNum({required num postId}) async {
    emit(GetCommentsNumberLoadingState());

    final response =
        await communityRepoImplementation.getCommentsNumber(postId: postId);

    response.fold(
      (error) => emit(GetCommentsNumberFailureState(errorMessage: error)),
      (success) => emit(GetCommentsNumberSuccessState(commentsNum: success)),
    );
  }

  //get one post
  getOnePost({required num postId}) async {
    emit(GetOnePostLoadingState());

    final response =
        await communityRepoImplementation.getOnePost(postId: postId);

    response.fold(
      (error) {
        emit(GetOnePostFailureState(errorMessage: error));
        return response;
      },
      (success) {
        emit(GetOnePostSuccessState(onePostModel: success));
        return response;
      },
    );
  }
}
