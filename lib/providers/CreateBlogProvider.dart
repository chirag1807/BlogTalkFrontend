import 'dart:collection';
import 'dart:io';

import 'package:blogtalk/repositories/BlogPost.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../models/ListAndMap.dart';
import '../repositories/UserRegLogin.dart';

class CreateBlogProvider extends ChangeNotifier{
  Map<int, String> topicNameIds = <int, String>{};
  int circularBarShow = 1;
  int blogTopic = -1;
  XFile? imageFile;
  int circularBarShowBlogPost = -1;
  int successUploadPost = -1;

  void getAllTopicNameIds() async {
    ListAndMap? topicNameIdsWithFavTopics = await UserRegLogin().getAllTopicNameId();
    topicNameIds = topicNameIdsWithFavTopics!.allTopicsNameId;
     circularBarShow = 0;
    notifyListeners();
  }

  void changeBlogTopic(int topic) async {
    blogTopic = topic;
    notifyListeners();
  }

  void pickImage(XFile imgFile) async {
      imageFile = imgFile;
      notifyListeners();
  }

  void uploadPost(String title, String content, int topic, File? coverImg) async {
    circularBarShowBlogPost = 1;
    notifyListeners();
    BlogPost blogPost = BlogPost();
    int? a = await blogPost.uploadPost(title, content, topic, coverImg);
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