class TopicNameId {
  String? msg;
  List<Result>? result;

  TopicNameId({this.msg, this.result});

  TopicNameId.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? sId;
  int? topicId;
  String? topicName;
  int? followed;
  int? muted;
  int? iV;

  Result(
      {this.sId,
        this.topicId,
        this.topicName,
        this.followed,
        this.muted,
        this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    topicId = json['topicId'];
    topicName = json['topicName'];
    followed = json['followed'];
    muted = json['muted'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['topicId'] = this.topicId;
    data['topicName'] = this.topicName;
    data['followed'] = this.followed;
    data['muted'] = this.muted;
    data['__v'] = this.iV;
    return data;
  }
}