class FollowersModel {
  String? followerUid;
  int? isFollowing;
  User? user;

  FollowersModel({this.followerUid, this.isFollowing, this.user});

  FollowersModel.fromJson(Map<String, dynamic> json) {
    followerUid = json['followerUid'];
    isFollowing = json['isFollowing'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['followerUid'] = followerUid;
    data['isFollowing'] = isFollowing;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
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

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['bio'] = bio;
    data['emailId'] = emailId;
    data['password'] = password;
    data['image'] = image;
    data['sendEmail'] = sendEmail;
    data['sendNotification'] = sendNotification;
    data['favTopicsCount'] = favTopicsCount;
    data['favTopics'] = favTopics;
    data['followersCount'] = followersCount;
    data['followers'] = followers;
    data['followingsCount'] = followingsCount;
    data['followings'] = followings;
    data['muted'] = muted;
    data['__v'] = iV;
    return data;
  }
}