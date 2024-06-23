class CommentOwner {
  int? id;
  String? name;
  String? email;
  String? displayName;
  String? profilePicture;
  String? profilePictureUrl;

  CommentOwner(
      {this.id,
        this.name,
        this.email,
        this.displayName,
        this.profilePicture,
        this.profilePictureUrl});

  CommentOwner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    displayName = json['display_name'];
    profilePicture = json['profile_picture'];
    profilePictureUrl = json['profile_picture_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['display_name'] = this.displayName;
    data['profile_picture'] = this.profilePicture;
    data['profile_picture_url'] = this.profilePictureUrl;
    return data;
  }
}