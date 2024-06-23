import 'package:graduation/features/community/data/models/search_model/search_comment.dart';

import 'search_user.dart';

/// id : 7
/// user_id : 13
/// post_text : "example post"
/// attachments : null
/// privacy : "public"
/// post_type : "article"
/// upvotes : 0
/// downvotes : 0
/// created_at : "2024-05-29T14:24:15.000000Z"
/// updated_at : "2024-05-29T14:24:15.000000Z"
/// image_url : null
/// user : {"id":13,"name":"sally","email":"sally@gmail.com","email_verified_at":null,"display_name":"sally","location":null,"profile_picture":"profile_pictures\\1715375292_short red dress.jpg","created_at":"2024-05-10T15:05:33.000000Z","updated_at":"2024-05-21T02:00:23.000000Z","gender":"female","type":"user","medical_license":null,"status":"approved","profile_picture_url":"http://b45a-197-54-180-184.ngrok-free.app/storage/profile_pictures\\1715375292_short red dress.jpg"}
/// comments : []

class SearchPosts {
  SearchPosts({
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
      this.imageUrl, 
      this.user, 
      this.comments,});

  SearchPosts.fromJson(dynamic json) {
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
    imageUrl = json['image_url'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments?.add(SearchComment.fromJson(v));
      });
    }
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
  dynamic imageUrl;
  User? user;
  List<dynamic>? comments;

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
    map['image_url'] = imageUrl;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (comments != null) {
      map['comments'] = comments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}