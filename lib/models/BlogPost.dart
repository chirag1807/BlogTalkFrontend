class BlogPostModel {
  String? sId;
  String? title;
  String? content;
  int? topic;
  String? author;
  String? coverImage;
  int? readMinute;
  List<String>? views;
  int? noOfViews;
  List<String>? likes;
  int? noOfLikes;
  String? publishedAt;
  int? iV;
  int? likedOrNot;

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
        this.likedOrNot});

  BlogPostModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    content = json['content'];
    topic = json['topic'];
    author = json['author'];
    coverImage = json['coverImage'];
    readMinute = json['readMinute'];
    views = json['views'].cast<String>();
    noOfViews = json['noOfViews'];
    likes = json['likes'].cast<String>();
    noOfLikes = json['noOfLikes'];
    publishedAt = json['publishedAt'];
    iV = json['__v'];
    likedOrNot = json['likedOrNot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['content'] = content;
    data['topic'] = topic;
    data['author'] = author;
    data['coverImage'] = coverImage;
    data['readMinute'] = readMinute;
    data['views'] = views;
    data['noOfViews'] = noOfViews;
    data['likes'] = likes;
    data['noOfLikes'] = noOfLikes;
    data['publishedAt'] = publishedAt;
    data['__v'] = iV;
    data['likedOrNot'] = likedOrNot;
    return data;
  }
}

