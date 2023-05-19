import 'package:blogtalk/models/BlogPost.dart';
import 'package:blogtalk/repositories/BlogPost.dart';
import 'package:flutter/cupertino.dart';

class BottomNavIndexChangeProvider extends ChangeNotifier{
  int myIndex = 0;
  List<BlogPostModel>? allPosts;
  int circularBarAllPostsShow = 1;
  int successFetchAllPosts = -1;

  void changeIndex(int index){
    myIndex = index;
    print("myIndex : $myIndex");
    notifyListeners();
  }

  void fetchUserAllPosts() async {
    allPosts = await BlogPost().getUserAllPosts();
    print("all post fetched");
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
      successFetchAllPosts = 1;
      circularBarAllPostsShow = 0;
      notifyListeners();
    }
  }
}