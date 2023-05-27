import 'dart:io';
import 'package:blogtalk/repositories/BlogPost.dart';
import 'package:flutter/widgets.dart';

import '../models/ListAndMap.dart';
import '../repositories/UserRegLogin.dart';

class CreateBlogProvider extends ChangeNotifier{
  Map<int, String> topicNameIds = <int, String>{};
  int circularBarShow = 1;
  int blogTopic = -1;
  File? imageFile;
  int circularBarShowBlogPost = -1;
  int successUploadPost = -1;

  void getAllTopicNameIds(int blogTopicValue) async {
    ListAndMap? topicNameIdsWithFavTopics = await UserRegLogin().getAllTopicNameId();
    topicNameIds = topicNameIdsWithFavTopics!.allTopicsNameId;
     circularBarShow = 0;
     blogTopic = blogTopicValue;
    notifyListeners();
  }

  void changeBlogTopic(int topic) async {
    blogTopic = topic;
    notifyListeners();
  }

  void pickImage(File imgFile) async {
      imageFile = imgFile;
      notifyListeners();
  }

  void uploadPost(String id, String title, String content, int topic, File? coverImg, int indicator) async {
    circularBarShowBlogPost = 1;
    notifyListeners();
    int? a = await BlogPost().uploadPost(id, title, content, topic, coverImg, indicator);
    if(a == 1){
      circularBarShowBlogPost = 0;
      successUploadPost = 1;
      notifyListeners();
    }
    else{
      circularBarShowBlogPost = 0;
      successUploadPost = 0;
      notifyListeners();
    }
  }
}