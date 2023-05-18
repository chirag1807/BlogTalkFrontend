class UserFavTopics {
  List<Result>? result;
  String? msg;

  UserFavTopics({this.result, this.msg});

  UserFavTopics.fromJson(Map<String, dynamic> json) {
    print(json);
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Result {
  String? sId;
  int? favTopicsCount;
  List<int>? favTopics;
  int? iV;

  Result({this.sId, this.favTopicsCount, this.favTopics, this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    favTopicsCount = json['favTopicsCount'];
    favTopics = json['favTopics'].cast<int>();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['favTopicsCount'] = this.favTopicsCount;
    data['favTopics'] = this.favTopics;
    data['__v'] = this.iV;
    return data;
  }
}