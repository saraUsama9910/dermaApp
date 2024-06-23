import 'Comments.dart';
import 'User.dart';

/// id : 1
/// user_id : 15
/// post_text : "sasa is back"
/// attachments : null
/// privacy : "public"
/// post_type : "article"
/// upvotes : 3
/// downvotes : 0
/// created_at : "2024-05-10T21:03:03.000000Z"
/// updated_at : "2024-06-13T09:56:37.000000Z"
/// comments_count : 2
/// image_url : null
/// comments : [{"id":42,"comment_content":"our new comment","post_id":1,"user_id":33,"created_at":"2024-06-12T16:04:32.000000Z","updated_at":"2024-06-12T16:04:51.000000Z","user":{"id":33,"name":"sara","email":"sarausama2@gmail.com","email_verified_at":null,"display_name":"sara usama","location":null,"profile_picture":null,"created_at":"2024-05-30T02:21:43.000000Z","updated_at":"2024-06-13T09:56:15.000000Z","gender":"female","type":"user","medical_license":null,"status":"approved","profile_picture_url":null}},{"id":43,"comment_content":"my new comment","post_id":1,"user_id":33,"created_at":"2024-06-12T19:57:31.000000Z","updated_at":"2024-06-12T19:58:39.000000Z","user":{"id":33,"name":"sara","email":"sarausama2@gmail.com","email_verified_at":null,"display_name":"sara usama","location":null,"profile_picture":null,"created_at":"2024-05-30T02:21:43.000000Z","updated_at":"2024-06-13T09:56:15.000000Z","gender":"female","type":"user","medical_license":null,"status":"approved","profile_picture_url":null}}]
/// user : {"id":15,"name":"essam","email":"Lola40040@gmail.com","email_verified_at":null,"display_name":"essam_sasa","location":null,"profile_picture":"profile_pictures/1715375120_duck.jpeg","created_at":"2024-05-10T21:02:09.000000Z","updated_at":"2024-05-24T01:36:31.000000Z","gender":"male","type":"user","medical_license":null,"status":"approved","profile_picture_url":"http://7a1d-197-54-180-184.ngrok-free.app/storage/profile_pictures/1715375120_duck.jpeg"}

class AllPostsData {
  AllPostsData({
      this.id, 
      this.userId, 
      this.postText, 
      this.attachments, 
      this.privacy, 
      this.postType, 
      this.upvotes, 
      this.downvotes, 
      this.createdAt, 
      this.updatedAt, 
      this.commentsCount, 
      this.imageUrl, 
      this.comments, 
      this.user,});

  AllPostsData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    postText = json['post_text'];
    attachments = json['attachments'];
    privacy = json['privacy'];
    postType = json['post_type'];
    upvotes = json['upvotes'];
    downvotes = json['downvotes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    commentsCount = json['comments_count'];
    imageUrl = json['image_url'];
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments?.add(AllPostsComments.fromJson(v));
      });
    }
    user = json['user'] != null ? AllPostsUsers.fromJson(json['user']) : null;
  }
  num? id;
  num? userId;
  String? postText;
  dynamic attachments;
  String? privacy;
  String? postType;
  num? upvotes;
  num? downvotes;
  String? createdAt;
  String? updatedAt;
  num? commentsCount;
  dynamic imageUrl;
  List<AllPostsComments>? comments;
  AllPostsUsers? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['post_text'] = postText;
    map['attachments'] = attachments;
    map['privacy'] = privacy;
    map['post_type'] = postType;
    map['upvotes'] = upvotes;
    map['downvotes'] = downvotes;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['comments_count'] = commentsCount;
    map['image_url'] = imageUrl;
    if (comments != null) {
      map['comments'] = comments?.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}