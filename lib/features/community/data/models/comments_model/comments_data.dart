import '../../../../auth/data/models/login_model/User.dart';

class CommentData {
  int? id;
  String? commentContent;
  String? createdAt;
  String? updatedAt;
  User? user;

  CommentData(
      {this.id,
        this.commentContent,
        this.createdAt,
        this.updatedAt,
        this.user});

  CommentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentContent = json['comment_content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment_content'] = this.commentContent;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
