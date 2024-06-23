part of 'global_community_cubit.dart';

@immutable
abstract class GlobalCommunityState {}

class GlobalCommunityInitial extends GlobalCommunityState {}

class GetAllPostsLoadingState extends GlobalCommunityState {}


class GetAllPostsSuccessState extends GlobalCommunityState {

  final AllPostsModel getAllPostsModel;
  GetAllPostsSuccessState({required this.getAllPostsModel});
}


class GetAllPostsFailureState extends GlobalCommunityState {

  final String errorMessage;
  GetAllPostsFailureState({required this.errorMessage});
}

class AddLikeForPostLoadingState extends GlobalCommunityState {}




class AddLikeForPostSuccessState extends GlobalCommunityState {
  final String successMessage;

  AddLikeForPostSuccessState({required this.successMessage});
}


class AddLikeForPostFailureState extends GlobalCommunityState {

  final String errorMessage;

  AddLikeForPostFailureState({required this.errorMessage});
}

class DownvotePostLoadingState extends GlobalCommunityState {}


class DownvotePostSuccessState extends GlobalCommunityState {
  final String successMessage;

  DownvotePostSuccessState({required this.successMessage});
}


class DownvotePostFailureState extends GlobalCommunityState {

  final String errorMessage;

  DownvotePostFailureState({required this.errorMessage});
}

class GetAllCommentsLoadingState extends GlobalCommunityState {}

class GetAllCommentsSuccessState extends GlobalCommunityState {
  final CommentsModel commentsModel;

  GetAllCommentsSuccessState({required this.commentsModel});

}


class GetAllCommentsFailureState extends GlobalCommunityState {

}

class AddCommentLoadingState extends GlobalCommunityState {}

class AddCommentSuccessState extends GlobalCommunityState {

  final String successMessage;

  AddCommentSuccessState({required this.successMessage});

}

class AddCommentFailureState extends GlobalCommunityState
{
  final String errorMessage;
  AddCommentFailureState({required this.errorMessage});

}

class DeletePostLoadingState extends GlobalCommunityState {}

class DeletePostSuccessState extends GlobalCommunityState {

  final String successMessage;
  DeletePostSuccessState({required this.successMessage});
}

class DeletePostFailureState extends GlobalCommunityState {

  final String errorMessage;
  DeletePostFailureState({required this.errorMessage});

}


class PhotoUpdatedForPostState extends GlobalCommunityState {}

class PhotoDeletedForEditPostState extends GlobalCommunityState {}


class DeletedMainUpdatedPostImage extends GlobalCommunityState {}





class ChangePostsNumber extends GlobalCommunityState {}



class UpdatePostLoadingState extends GlobalCommunityState {}

class UpdatePostSuccessState extends GlobalCommunityState {
  final String successMessage;

  UpdatePostSuccessState({required this.successMessage});

}


class UpdatePostFailureState extends GlobalCommunityState
{
  final String errorMessage;
  UpdatePostFailureState({required this.errorMessage});
}


class UpdateCommentLoadingState extends GlobalCommunityState {}

class UpdateCommentSuccessState extends GlobalCommunityState {
  final String successMessage;

  UpdateCommentSuccessState({required this.successMessage});
}


class UpdateCommentFailureState extends GlobalCommunityState
{
  final String errorMessage;
  UpdateCommentFailureState({required this.errorMessage});
}

class DeleteCommentLoadingState extends GlobalCommunityState {}

class DeleteCommentSuccessState extends GlobalCommunityState {
  final String successMessage;

  DeleteCommentSuccessState({required this.successMessage});
}

class DeleteCommentFailureState extends GlobalCommunityState
{
  final String errorMessage;
  DeleteCommentFailureState({required this.errorMessage});
}


class UpdatedPhotoAddedForPostState extends GlobalCommunityState {}


class GetUpvotesNumLoadingState extends GlobalCommunityState {}


class GetUpvotesNumSuccessState extends GlobalCommunityState {

  final int upvotesNum;

  GetUpvotesNumSuccessState({required this.upvotesNum});
}


class GetUpvotesNumFailureState extends GlobalCommunityState {
  final String errorMessage;
  GetUpvotesNumFailureState({required this.errorMessage});
}


class GetDownvotesNumLoadingState extends GlobalCommunityState {}


class GetDownvotesNumSuccessState extends GlobalCommunityState {

  final int downvotesNum;

  GetDownvotesNumSuccessState({required this.downvotesNum});
}


class GetDownvotesNumFailureState extends GlobalCommunityState {
  final String errorMessage;
  GetDownvotesNumFailureState({required this.errorMessage});
}


class GetCommentsNumberLoadingState extends GlobalCommunityState {}


class GetCommentsNumberSuccessState extends GlobalCommunityState {
  final int commentsNum;

  GetCommentsNumberSuccessState({required this.commentsNum});
}


class GetCommentsNumberFailureState extends GlobalCommunityState {
  final String errorMessage;
  GetCommentsNumberFailureState({required this.errorMessage});
}


class GetOnePostLoadingState extends GlobalCommunityState {}


class GetOnePostSuccessState extends GlobalCommunityState {
  final OnePostModel onePostModel;

  GetOnePostSuccessState({required this.onePostModel});
}


class GetOnePostFailureState extends GlobalCommunityState {
  final String errorMessage;
  GetOnePostFailureState({required this.errorMessage});
}

























