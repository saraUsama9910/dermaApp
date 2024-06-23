import 'package:graduation/features/community/data/models/comments_model/comments_model.dart';

import 'one_post_data.dart';

/// post : {"id":2,"user":{"id":13,"name":"sally","email":"sally@gmail.com","email_verified_at":null,"display_name":"sally","location":null,"profile_picture":"profile_pictures\\1715375292_short red dress.jpg","created_at":"2024-05-10T15:05:33.000000Z","updated_at":"2024-05-21T02:00:23.000000Z","gender":"female","type":"user","medical_license":null,"status":"approved","profile_picture_url":"http://7a1d-197-54-180-184.ngrok-free.app/storage/profile_pictures\\1715375292_short red dress.jpg"},"post_text":"updated","attachments":null,"image_url":null,"privacy":"public","post_type":"article","upvotes":0,"downvotes":0,"created_at":"2024-05-10T21:11:36.000000Z","updated_at":"2024-06-06T00:55:10.000000Z","comments_count":0}
/// comments : []

class OnePostModel {
  OnePostModel({
      this.post, 
      this.comments,});

  OnePostModel.fromJson(dynamic json) {
    post = json['post'] != null ? OnePostData.fromJson(json['post']) : null;
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments?.add(CommentsModel.fromJson(v));
      });
    }
  }
  OnePostData? post;
  List<dynamic>? comments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (post != null) {
      map['post'] = post?.toJson();
    }
    if (comments != null) {
      map['comments'] = comments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}