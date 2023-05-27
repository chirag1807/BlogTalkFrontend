class BlogPostWithAuthor {
  String? id;
  String? title;
  int? topic;
  String? image;
  String? publishedAt;
  int? readMinute;
  int? followingOrNot;
  Author? author;

  BlogPostWithAuthor(
      {this.id,
        this.title,
        this.topic,
        this.image,
        this.publishedAt,
        this.readMinute,
        this.followingOrNot,
        this.author});

  BlogPostWithAuthor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    topic = json['topic'];
    image = json['image'];
    publishedAt = json['publishedAt'];
    readMinute = json['readMinute'];
    followingOrNot = json['followingOrNot'];
    author =
    json['author'] != null ? Author.fromJson(json['author']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['topic'] = topic;
    data['image'] = image;
    data['publishedAt'] = publishedAt;
    data['readMinute'] = readMinute;
    data['followingOrNot'] = followingOrNot;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    return data;
  }
}

class Author {
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

  Author(
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

  Author.fromJson(Map<String, dynamic> json) {
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