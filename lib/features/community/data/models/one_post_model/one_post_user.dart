/// id : 13
/// name : "sally"
/// email : "sally@gmail.com"
/// email_verified_at : null
/// display_name : "sally"
/// location : null
/// profile_picture : "profile_pictures\\1715375292_short red dress.jpg"
/// created_at : "2024-05-10T15:05:33.000000Z"
/// updated_at : "2024-05-21T02:00:23.000000Z"
/// gender : "female"
/// type : "user"
/// medical_license : null
/// status : "approved"
/// profile_picture_url : "http://7a1d-197-54-180-184.ngrok-free.app/storage/profile_pictures\\1715375292_short red dress.jpg"

class OnePostUserData {
  OnePostUserData({
      this.id, 
      this.name, 
      this.email, 
      this.emailVerifiedAt, 
      this.displayName, 
      this.location, 
      this.profilePicture, 
      this.createdAt, 
      this.updatedAt, 
      this.gender, 
      this.type, 
      this.medicalLicense, 
      this.status, 
      this.profilePictureUrl,});

  OnePostUserData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    displayName = json['display_name'];
    location = json['location'];
    profilePicture = json['profile_picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    gender = json['gender'];
    type = json['type'];
    medicalLicense = json['medical_license'];
    status = json['status'];
    profilePictureUrl = json['profile_picture_url'];
  }
  num? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? displayName;
  dynamic location;
  String? profilePicture;
  String? createdAt;
  String? updatedAt;
  String? gender;
  String? type;
  dynamic medicalLicense;
  String? status;
  String? profilePictureUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['display_name'] = displayName;
    map['location'] = location;
    map['profile_picture'] = profilePicture;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['gender'] = gender;
    map['type'] = type;
    map['medical_license'] = medicalLicense;
    map['status'] = status;
    map['profile_picture_url'] = profilePictureUrl;
    return map;
  }

}