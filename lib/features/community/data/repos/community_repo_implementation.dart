import 'package:dartz/dartz.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:graduation/core/api/api_consumer.dart';
import 'package:graduation/core/api/api_endPoints.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/errors/handle_error.dart';
import 'package:graduation/features/community/data/models/comments_model/comments_model.dart';
import 'package:graduation/features/community/data/models/get_all_posts_model/AllPostsModel.dart';
import 'package:graduation/features/community/data/models/one_post_model/one_post_model.dart';
import 'package:graduation/features/community/data/models/search_model/search_model.dart';
import 'package:graduation/features/community/data/repos/community_repo.dart';

class CommunityRepoImplementation implements CommunityRepo {
  final ApiConsumer apiConsumer;

  CommunityRepoImplementation({required this.apiConsumer});

  @override
  Future<Either<String, AllPostsModel>> getAllPosts(
      {required String token}) async {
    try {
      final response =
          await apiConsumer.get(EndPoints.getAllPostsEndPoint(token: token));
      AllPostsModel getAllPostsModel = AllPostsModel.fromJson(response);
      return Right(getAllPostsModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, String>> upvatePost({required num postId}) async {
    try {
      final response =
          await apiConsumer.post(EndPoints.upvotePostEndPoint(postId: postId));
      return Right(response[ApiKeys.message]);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, String>> downvatePost({required num postId}) async {
    try {
      final response = await apiConsumer
          .post(EndPoints.downvotePostEndPoint(postId: postId));
      return Right(response[ApiKeys.message]);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, String>> addComment(
      {required num postId, required String comment}) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.addCommentEndPoint,
        data: {ApiKeys.comment_content: comment, ApiKeys.post_id: postId},
      );
      return Right(response[ApiKeys.message]);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, String>> deletePost({required num postId}) async {
    try {
      final response = await apiConsumer
          .delete(EndPoints.deletePostEndPoint(postId: postId));
      return Right(response[ApiKeys.message]);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, String>> addPost(
      {String? postText, MultipartFile? postImage}) async {
    try {
      final Map<String, dynamic> data = {};

      if (postImage != null) {
        data[ApiKeys.attachments] = postImage;
      }
      if (postText != null && postText != "") {
        data[ApiKeys.post_text] = postText;
      }
      final response = await apiConsumer.post(EndPoints.createPostEndPoint,
          data: data, isFormData: true);
      return Right(response[ApiKeys.message]);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<SearchModel> searchForPosts({required String query}) async {
    final response = await apiConsumer.post(EndPoints.searchForPostsEndPoint,
        data: {ApiKeys.query: query}, isFormData: true);
    SearchModel searchModel = SearchModel.fromJson(response);

    return searchModel;
  }

  @override
  Future<CommentsModel> getCommnetsOnPost({required num postId}) async {
    final response = await apiConsumer
        .get(EndPoints.getCommentsOnPostEndPoint(postId: postId));
    CommentsModel commentsModel = CommentsModel.fromJson(response);
    return commentsModel;
  }

  @override
  Future<Either<String, String>> deleteComment({required num commentId}) async {
    try {
      final response = await apiConsumer
          .delete(EndPoints.deleteCommentEndPoint(commentId: commentId));
      return Right(response[ApiKeys.message]);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, String>> updateComment(
      {required String newContent, required num commentId}) async {
    try {
      final response = await apiConsumer.post(
          EndPoints.updateCommentEndPoint(commentId: commentId),
          data: {ApiKeys.comment_content: newContent});
      return Right(response[ApiKeys.message]);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, String>> updatePost(
      {required num postId,
      String? postText,
      MultipartFile? attachment}) async {
    try {
      Map<String, dynamic> data = {};
      if (postText != null && postText != '') {
        data[ApiKeys.post_text] = postText;
      }
      if (attachment != null) {
        data[ApiKeys.attachments] = attachment;
      }
      final response = await apiConsumer.post(
          EndPoints.updatePostEndPoint(postId: postId),
          data: data,
          isFormData: true);
      return Right(response[ApiKeys.message]);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, int>> getCommentsNumber({required num postId}) async {
    try {
      final response = await apiConsumer
          .get(EndPoints.getCommentsNumberEndPoint(postId: postId));
      return Right(response['data']['commentsCount']);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, int>> getDownvotesNumber({required num postId}) async {
    try {
      final response = await apiConsumer
          .get(EndPoints.getDownvotesNumberEndPoint(postId: postId));
      return Right(response['data']['downvotes']);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, int>> getUpvotesNumber({required num postId}) async {
    try {
      final response = await apiConsumer
          .get(EndPoints.getUpvotesNumberEndPoint(postId: postId));
      return Right(response['data']['upvotes']);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, OnePostModel>> getOnePost({required num postId}) async {
    try {
      final response =
          await apiConsumer.get(EndPoints.getOnePostEndPoint(postId: postId));
      OnePostModel onePostModel = OnePostModel.fromJson(response);
      return Right(onePostModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
