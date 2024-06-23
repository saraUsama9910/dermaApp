/// id : 33
/// name : "sara"
/// email : "sarausama2@gmail.com"
/// display_name : ""
/// profile_picture : null
/// gender : "female"
/// type : "user"
/// api_token : "o1NovzFFjCfe3j9ZIQdlTV4zJloRDZL2Jwf3jfWhsbHoz4D7LG54WhgApvtt"

class User {
  User({
      this.id, 
      this.name, 
      this.email, 
      this.displayName, 
      this.profilePicture, 
      this.gender, 
      this.type, 
      this.apiToken,});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    displayName = json['display_name'];
    profilePicture = json['profile_picture'];
    gender = json['gender'];
    type = json['type'];
    apiToken = json['api_token'];
  }
  num? id;
  String? name;
  String? email;
  String? displayName;
  dynamic profilePicture;
  String? gender;
  String? type;
  String? apiToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['display_name'] = displayName;
    map['profile_picture'] = profilePicture;
    map['gender'] = gender;
    map['type'] = type;
    map['api_token'] = apiToken;
    return map;
  }

}