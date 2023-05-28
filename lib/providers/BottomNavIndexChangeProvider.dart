import 'package:blogtalk/models/BlogPostWithAuthor.dart';
import 'package:blogtalk/repositories/BlogPost.dart';
import 'package:blogtalk/repositories/UserRegLogin.dart';
import 'package:flutter/material.dart';

import '../models/SaveToDraft.dart';
import '../models/UserAllPost.dart';
import '../repositories/UserProfileSetting.dart';
import '../sqflite/database_helper.dart';

class BottomNavIndexChangeProvider extends ChangeNotifier{
  int myIndex = 0;
  List<UserAllPost>? allPosts;
  List<BlogPostWithAuthor>? savedPosts;
  Map<int, String>? topicNameIds;
  int circularBarAllPostsShow = 1;
  int successFetchAllPosts = -1;
  int circularBarSavedPostsShow = 1;
  int successFetchSavedPosts = -1;

  //for userprofile screen
  int initialIndicator = 0;
  bool emailState = true;
  bool notificationState = true;
  int circularBarShowAllParticularSavePost = 1;
  int successFetchAllParticularSavePost = -1;
  List<SaveToDraft>? savedDraftPosts;
  SaveToDraft? savedDraftPost;
  int successDeletePost = -1;


  void changeIndex(int index){
    myIndex = index;
    print("myIndex : $myIndex");
    notifyListeners();
  }

  void fetchUserAllPosts() async {
    allPosts = await BlogPost().getUserAllPosts();

    if(allPosts == null){
      successFetchAllPosts = 0;
      circularBarAllPostsShow = 0;
      notifyListeners();
    }
    else if(allPosts!.isEmpty){
      successFetchAllPosts = 2;
      circularBarAllPostsShow = 0;
      notifyListeners();
    }
    else{
      topicNameIds?.clear();
      print("yes10");
      topicNameIds = await UserRegLogin().getOnlyTopicNameIds();
      successFetchAllPosts = 1;
      circularBarAllPostsShow = 0;
      notifyListeners();
    }
  }

  void deleteUserPost(int index) async {
    // await BlogPost().deletePost(allPosts![index].id ?? "");
    allPosts?.removeAt(index);
    notifyListeners();
  }

  void fetchUserSavedPosts() async {
    savedPosts = await BlogPost().getSavedPosts();

    if(savedPosts == null){
      successFetchSavedPosts = 0;
      circularBarSavedPostsShow = 0;
      notifyListeners();
    }
    else if(savedPosts!.isEmpty){
      successFetchSavedPosts = 2;
      circularBarSavedPostsShow = 0;
      notifyListeners();
    }
    else{
      topicNameIds?.clear();
      topicNameIds = await UserRegLogin().getOnlyTopicNameIds();
      successFetchSavedPosts = 1;
      circularBarSavedPostsShow = 0;
      notifyListeners();
    }
  }


  //for userprofile screen
  void setInitState(bool emailInitialState, bool notificationInitialState){
    initialIndicator = 1;
    emailState = emailInitialState;
    notificationState = notificationInitialState;
    notifyListeners();
  }

  void changeState(bool state, int indicator) async {
    if(indicator == 0){
      emailState = state;
      notifyListeners();
    }
    else{
      notificationState = state;
      notifyListeners();
    }
    await UserProfileSetting().updateSendEmailNotif(indicator, state);
  }

  void getAllPosts() async {
    DatabaseHelper databaseHelper = DatabaseHelper();

    List<SaveToDraft>? blogPosts = await databaseHelper.getAllPosts();
    if(blogPosts.isNotEmpty){
      successFetchAllParticularSavePost = 1;
      savedDraftPosts = blogPosts;
      circularBarShowAllParticularSavePost = 0;
      if(topicNameIds == null){
        topicNameIds?.clear();
        topicNameIds = await UserRegLogin().getOnlyTopicNameIds();
      }
      notifyListeners();
    }
    else if(blogPosts.isEmpty){
      print("yes2");
      successFetchAllParticularSavePost = 2;
      circularBarShowAllParticularSavePost = 0;
      notifyListeners();
    }
    else{
      print("yes3");
      successFetchAllParticularSavePost = 0;
      circularBarShowAllParticularSavePost = 0;
      notifyListeners();
    }
  }

  void getParticularPost() async {
    circularBarShowAllParticularSavePost = 1;
    notifyListeners();

    DatabaseHelper databaseHelper = DatabaseHelper();

    SaveToDraft? blogPost = await databaseHelper.getPostById(1);
    if(blogPost != null){
      successFetchAllParticularSavePost = 1;
      savedDraftPost= blogPost;
      circularBarShowAllParticularSavePost = 0;
      notifyListeners();
    }
    else{
      successFetchAllParticularSavePost = 0;
      circularBarShowAllParticularSavePost = 0;
      notifyListeners();
    }
  }

  void deleteParticularPost(int id, int index) async {
    DatabaseHelper databaseHelper = DatabaseHelper();

    int a = await databaseHelper.deletePost(id);
    if(a == 1){
      successDeletePost = 1;
      savedDraftPosts!.removeAt(index);
      notifyListeners();
    }
    else{
      successDeletePost = 0;
      notifyListeners();
    }
  }
}