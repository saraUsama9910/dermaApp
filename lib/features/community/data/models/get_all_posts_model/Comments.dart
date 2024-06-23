import 'User.dart';

/// id : 42
/// comment_content : "our new comment"
/// post_id : 1
/// user_id : 33
/// created_at : "2024-06-12T16:04:32.000000Z"
/// updated_at : "2024-06-12T16:04:51.000000Z"
/// user : {"id":33,"name":"sara","email":"sarausama2@gmail.com","email_verified_at":null,"display_name":"sara usama","location":null,"profile_picture":null,"created_at":"2024-05-30T02:21:43.000000Z","updated_at":"2024-06-13T09:56:15.000000Z","gender":"female","type":"user","medical_license":null,"status":"approved","profile_picture_url":null}

class AllPostsComments {
  AllPostsComments({
      this.id, 
      this.commentContent, 
      this.postId, 
      this.userId, 
      this.createdAt, 
      this.updatedAt, 
      this.user,});

  AllPostsComments.fromJson(dynamic json) {
    id = json['id'];
    commentContent = json['comment_content'];
    postId = json['post_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? AllPostsUsers.fromJson(json['user']) : null;
  }
  num? id;
  String? commentContent;
  num? postId;
  num? userId;
  String? createdAt;
  String? updatedAt;
  AllPostsUsers? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['comment_content'] = commentContent;
    map['post_id'] = postId;
    map['user_id'] = userId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}