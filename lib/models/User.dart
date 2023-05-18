//model class for user registration and login
class User {
  Result? result;
  String? accessToken;
  String? refreshToken;
  String? msg;

  User({this.result, this.accessToken, this.refreshToken, this.msg});

  User.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['msg'] = this.msg;
    return data;
  }
}

class Result {
  String? name;
  String? bio;
  String? emailId;
  String? password;
  String? image;
  bool? sendEmail;
  bool? sendNotification;
  int? favTopicsCount;
  String? favTopics;
  int? followersCount;
  String? followers;
  int? followingsCount;
  String? followings;
  String? muted;
  String? sId;
  int? iV;

  Result(
      {this.name,
        this.bio,
        this.emailId,
        this.password,
        this.image,
        this.sendEmail,
        this.sendNotification,
        this.favTopicsCount,
        this.favTopics,
        this.followersCount,
        this.followers,
        this.followingsCount,
        this.followings,
        this.muted,
        this.sId,
        this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bio = json['bio'];
    emailId = json['emailId'];
    password = json['password'];
    image = json['image'];
    sendEmail = json['sendEmail'];
    sendNotification = json['sendNotification'];
    favTopicsCount = json['favTopicsCount'];
    favTopics = json['favTopics'];
    followersCount = json['followersCount'];
    followers = json['followers'];
    followingsCount = json['followingsCount'];
    followings = json['followings'];
    muted = json['muted'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['emailId'] = this.emailId;
    data['password'] = this.password;
    data['image'] = this.image;
    data['sendEmail'] = this.sendEmail;
    data['sendNotification'] = this.sendNotification;
    data['favTopicsCount'] = this.favTopicsCount;
    data['favTopics'] = this.favTopics;
    data['followersCount'] = this.followersCount;
    data['followers'] = this.followers;
    data['followingsCount'] = this.followingsCount;
    data['followings'] = this.followings;
    data['muted'] = this.muted;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}


//reset token model class

// class resetToken {
//   String? accessToken;
//   String? refreshToken;
//   String? msg;
//
//   resetToken({this.accessToken, this.refreshToken, this.msg});
//
//   resetToken.fromJson(Map<String, dynamic> json) {
//     accessToken = json['accessToken'];
//     refreshToken = json['refreshToken'];
//     msg = json['msg'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['accessToken'] = this.accessToken;
//     data['refreshToken'] = this.refreshToken;
//     data['msg'] = this.msg;
//     return data;
//   }
// }


//forgot password send email model class

// class ForgotPasswordSendEmail {
//   String? msg;
//   Result? result;
//
//   ForgotPasswordSendEmail({this.msg, this.result});
//
//   ForgotPasswordSendEmail.fromJson(Map<String, dynamic> json) {
//     msg = json['msg'];
//     result =
//     json['result'] != null ? new Result.fromJson(json['result']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['msg'] = this.msg;
//     if (this.result != null) {
//       data['result'] = this.result!.toJson();
//     }
//     return data;
//   }
// }
//
// class Result {
//   int? code;
//   int? expiresIn;
//   String? sId;
//   int? iV;
//
//   Result({this.code, this.expiresIn, this.sId, this.iV});
//
//   Result.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     expiresIn = json['expiresIn'];
//     sId = json['_id'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['expiresIn'] = this.expiresIn;
//     data['_id'] = this.sId;
//     data['__v'] = this.iV;
//     return data;
//   }
// }