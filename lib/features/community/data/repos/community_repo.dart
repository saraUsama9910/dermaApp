

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:graduation/features/community/data/models/comments_model/comments_model.dart';
import 'package:graduation/features/community/data/models/get_all_posts_model/AllPostsModel.dart';
import 'package:graduation/features/community/data/models/one_post_model/one_post_model.dart';
import 'package:graduation/features/community/data/models/search_model/search_model.dart';

abstract class CommunityRepo
{

  Future<Either<String,OnePostModel>>getOnePost({required num postId});

  Future<Either<String,AllPostsModel>>getAllPosts({required String token});

  Future<Either<String,String>>upvatePost({required num postId});

  Future<Either<String,String>>downvatePost({required num postId});

  Future<CommentsModel>getCommnetsOnPost({required num postId});

  Future<Either<String,String>> addComment({required num postId,required String comment});

  Future<Either<String,String>> deletePost({required num postId});

  Future<Either<String,String>> addPost({String? postText,MultipartFile? postImage});

  Future<SearchModel> searchForPosts({required String query});

  Future<Either<String,String>>updatePost({required num postId,String? postText,MultipartFile? attachment});

  Future<Either<String,String>>updateComment({required String newContent,required num commentId});

  Future<Either<String,String>>deleteComment({required num commentId});

  Future<Either<String,int>>getUpvotesNumber({required num postId});

  Future<Either<String,int>>getDownvotesNumber({required num postId});

  Future<Either<String,int>>getCommentsNumber({required num postId});


  











}