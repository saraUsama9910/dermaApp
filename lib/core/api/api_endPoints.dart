class EndPoints {
  static String baseUrl = "https://2815-156-210-159-165.ngrok-free.app/api/";
  static String login = "login";

  static String register = 'register';

  static String forgotPassword = 'forgot-password';

  static String createPostEndPoint = 'posts/create';

  static String searchForPostsEndPoint = 'posts/search';

  static String getAllPostsEndPoint({required String token}) {
    return 'posts?Authorization=Bearer $token&=';
  }

  static String upvotePostEndPoint({required num postId}) {
    return 'posts/upvote/$postId';
  }

  static String downvotePostEndPoint({required num postId}) {
    return 'posts/downvote/$postId';
  }

  static String getCommentsOnPostEndPoint({required num postId}) {
    return 'posts/comments/$postId';
  }

  static String addCommentEndPoint = 'comments/create';

  static String deletePostEndPoint({required num postId}) {
    return 'posts/delete/$postId';
  }

  static String updatePostEndPoint({required num postId}) {
    return 'posts/update/$postId';
  }

  static String updateCommentEndPoint({required num commentId}) {
    return 'comments/update/$commentId';
  }

  static String deleteCommentEndPoint({required num commentId}) {
    return 'comments/delete/$commentId';
  }

  static String getUpvotesNumberEndPoint({required num postId}) {
    return 'posts/upvotes/$postId';
  }

  static String getDownvotesNumberEndPoint({required num postId}) {
    return 'posts/downvotes/$postId';
  }

  static String getCommentsNumberEndPoint({required num postId}) {
    return 'posts/comments/$postId';
  }

  static String getOnePostEndPoint({required num postId}) {
    return 'posts/show/$postId';
  }

  static String predict = 'predict';
  static String confidence = '$confidence';

  static String updateProfileEndPoint({required num userId}) {
    return 'users/update/$userId';
  }

  static String changePasswordEndPoint({required num userId}) {
    return 'change-password/$userId';
  }

  static String getUserDataEndPoint({required num userId}) {
    return 'users/show/$userId';
  }

  static String deleteUserEndPoint(
      {required num userId, required String token}) {
    return 'users/delete/$userId?Authorization=Bearer $token';
  }
}
