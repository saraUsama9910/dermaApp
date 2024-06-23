import 'one_post_user.dart';

/// id : 2
/// user : {"id":13,"name":"sally","email":"sally@gmail.com","email_verified_at":null,"display_name":"sally","location":null,"profile_picture":"profile_pictures\\1715375292_short red dress.jpg","created_at":"2024-05-10T15:05:33.000000Z","updated_at":"2024-05-21T02:00:23.000000Z","gender":"female","type":"user","medical_license":null,"status":"approved","profile_picture_url":"http://7a1d-197-54-180-184.ngrok-free.app/storage/profile_pictures\\1715375292_short red dress.jpg"}
/// post_text : "updated"
/// attachments : null
/// image_url : null
/// privacy : "public"
/// post_type : "article"
/// upvotes : 0
/// downvotes : 0
/// created_at : "2024-05-10T21:11:36.000000Z"
/// updated_at : "2024-06-06T00:55:10.000000Z"
/// comments_count : 0

class OnePostData {
  OnePostData({
      this.id, 
      this.user, 
      this.postText, 
      this.attachments, 
      this.imageUrl, 
      this.privacy, 
      this.postType, 
      this.upvotes, 
      this.downvotes, 
      this.createdAt, 
      this.updatedAt, 
      this.commentsCount,});

  OnePostData.fromJson(dynamic json) {
    id = json['id'];
    user = json['user'] != null ? OnePostUserData.fromJson(json['user']) : null;
    postText = json['post_text'];
    attachments = json['attachments'];
    imageUrl = json['image_url'];
    privacy = json['privacy'];
    postType = json['post_type'];
    upvotes = json['upvotes'];
    downvotes = json['downvotes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    commentsCount = json['comments_count'];
  }
  num? id;
  OnePostUserData? user;
  String? postText;
  dynamic attachments;
  dynamic imageUrl;
  String? privacy;
  String? postType;
  num? upvotes;
  num? downvotes;
  String? createdAt;
  String? updatedAt;
  num? commentsCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['post_text'] = postText;
    map['attachments'] = attachments;
    map['image_url'] = imageUrl;
    map['privacy'] = privacy;
    map['post_type'] = postType;
    map['upvotes'] = upvotes;
    map['downvotes'] = downvotes;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['comments_count'] = commentsCount;
    return map;
  }

}