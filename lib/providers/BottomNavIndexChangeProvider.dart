import 'package:blogtalk/models/BlogPostWithAuthor.dart';
import 'package:blogtalk/repositories/BlogPost.dart';
import 'package:blogtalk/repositories/UserRegLogin.dart';
import 'package:flutter/cupertino.dart';

import '../models/UserAllPost.dart';

class BottomNavIndexChangeProvider extends ChangeNotifier{
  int myIndex = 0;
  List<UserAllPost>? allPosts;
  List<BlogPostWithAuthor>? savedPosts;
  Map<int, String>? topicNameIds;
  int circularBarAllPostsShow = 1;
  int successFetchAllPosts = -1;
  int circularBarSavedPostsShow = 1;
  int successFetchSavedPosts = -1;

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
}