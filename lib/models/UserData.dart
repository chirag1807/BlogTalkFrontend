class UserData {
  Result? result;
  String? msg;

  UserData({this.result, this.msg});

  UserData.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Result {
  String? sId;
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
  int? iV;

  Result(
      {this.sId,
        this.name,
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
        this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
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
    data['__v'] = this.iV;
    return data;
  }
}