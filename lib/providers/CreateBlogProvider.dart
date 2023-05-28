import 'dart:io';
import 'package:blogtalk/repositories/BlogPost.dart';
import 'package:flutter/widgets.dart';

import '../models/ListAndMap.dart';
import '../repositories/UserRegLogin.dart';
import '../sqflite/database_helper.dart';

class CreateBlogProvider extends ChangeNotifier{
  Map<int, String> topicNameIds = <int, String>{};
  int circularBarShow = 1;
  int blogTopic = -1;
  File? imageFile;
  int circularBarShowBlogPost = -1;
  int successUploadPost = -1;
  int circularBarShowSaveBlogPost = -1;
  int successSavePost = -1;

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

  void savePostToDraft(String title, String content, int topic, String coverImgPath) async {
    circularBarShowSaveBlogPost = 1;
    notifyListeners();

    DatabaseHelper databaseHelper = DatabaseHelper();

    int id = await databaseHelper.saveData(title, content, topic, coverImgPath);
    if(id == -1){
      circularBarShowSaveBlogPost = 0;
      successSavePost = 0;
      notifyListeners();
    }
    else{
      circularBarShowSaveBlogPost = 0;
      successSavePost = 1;
      notifyListeners();
    }
  }

  void updatePostToDraft(int id, String title, String content, int topic, String coverImgPath) async {
    circularBarShowSaveBlogPost = 1;
    notifyListeners();

    DatabaseHelper databaseHelper = DatabaseHelper();
    int a = await databaseHelper.updateData(id, title, content, topic, coverImgPath);
    if(a == 1){
      circularBarShowSaveBlogPost = 0;
      successSavePost = 1;
      notifyListeners();
    }
    else{
      circularBarShowSaveBlogPost = 0;
      successSavePost = 0;
      notifyListeners();
    }
  }
}