class UserData {
  String? sId;
  String? name;
  String? bio;
  String? image;
  bool? sendEmail;
  bool? sendNotification;
  int? followingsCount;
  int? followersCount;
  int? postsCount;

  UserData(
      {this.sId,
        this.name,
        this.bio,
        this.image,
        this.sendEmail,
        this.sendNotification,
        this.followingsCount,
        this.followersCount,
        this.postsCount});

  UserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    bio = json['bio'];
    image = json['image'];
    sendEmail = json['sendEmail'];
    sendNotification = json['sendNotification'];
    followingsCount = json['followingsCount'];
    followersCount = json['followersCount'];
    postsCount = json['postsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['bio'] = bio;
    data['image'] = image;
    data['sendEmail'] = sendEmail;
    data['sendNotification'] = sendNotification;
    data['followingsCount'] = followingsCount;
    data['followersCount'] = followersCount;
    data['postsCount'] = postsCount;
    return data;
  }
}