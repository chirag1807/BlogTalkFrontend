class BlogPostModel {
  String? sId;
  String? title;
  String? content;
  int? topic;
  Author? author;
  String? coverImage;
  int? readMinute;
  List<String>? views;
  int? noOfViews;
  List<String>? likes;
  int? noOfLikes;
  String? publishedAt;
  int? iV;
  int? likedOrNot;
  int? followingOrNot;
  int? savedOrNot;

  BlogPostModel(
      {this.sId,
        this.title,
        this.content,
        this.topic,
        this.author,
        this.coverImage,
        this.readMinute,
        this.views,
        this.noOfViews,
        this.likes,
        this.noOfLikes,
        this.publishedAt,
        this.iV,
        this.likedOrNot,
        this.followingOrNot,
        this.savedOrNot});

  BlogPostModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    content = json['content'];
    topic = json['topic'];
    author =
    json['author'] != null ? Author.fromJson(json['author']) : null;
    coverImage = json['coverImage'];
    readMinute = json['readMinute'];
    views = json['views'].cast<String>();
    noOfViews = json['noOfViews'];
    likes = json['likes'].cast<String>();
    noOfLikes = json['noOfLikes'];
    publishedAt = json['publishedAt'];
    iV = json['__v'];
    likedOrNot = json['likedOrNot'];
    followingOrNot = json['followingOrNot'];
    savedOrNot = json['savedOrNot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['content'] = content;
    data['topic'] = topic;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    data['coverImage'] = coverImage;
    data['readMinute'] = readMinute;
    data['views'] = views;
    data['noOfViews'] = noOfViews;
    data['likes'] = likes;
    data['noOfLikes'] = noOfLikes;
    data['publishedAt'] = publishedAt;
    data['__v'] = iV;
    data['likedOrNot'] = likedOrNot;
    data['followingOrNot'] = followingOrNot;
    data['savedOrNot'] = savedOrNot;
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