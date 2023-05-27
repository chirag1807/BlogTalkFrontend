class UserAllPost {
  String? id;
  String? title;
  int? topic;
  String? image;
  String? publishedAt;
  int? readMinute;

  UserAllPost(
      {this.id,
        this.title,
        this.topic,
        this.image,
        this.publishedAt,
        this.readMinute});

  UserAllPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    topic = json['topic'];
    image = json['image'];
    publishedAt = json['publishedAt'];
    readMinute = json['readMinute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['topic'] = topic;
    data['image'] = image;
    data['publishedAt'] = publishedAt;
    data['readMinute'] = readMinute;
    return data;
  }
}