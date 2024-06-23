import 'User.dart';

/// message : "Login successful"
/// user : {"id":33,"name":"sara","email":"sarausama2@gmail.com","display_name":"","profile_picture":null,"gender":"female","type":"user","api_token":"o1NovzFFjCfe3j9ZIQdlTV4zJloRDZL2Jwf3jfWhsbHoz4D7LG54WhgApvtt"}

class LoginModel {
  LoginModel({
      this.message, 
      this.user,});

  LoginModel.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? message;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}