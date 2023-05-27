import 'package:blogtalk/models/BlogPost.dart';
import 'package:flutter/material.dart';

import '../repositories/BlogPost.dart';

class ReadBlogProvider extends ChangeNotifier{
  BlogPostModel? blogPost;
  int circularBarAllPostsShow = 1;
  int successFetchBlogPost = -1;

  void fetchBlogPost(String id) async {
    blogPost = await BlogPost().getParticularPost(id);

    if(blogPost != null){
      circularBarAllPostsShow = 0;
      successFetchBlogPost = 1;
      notifyListeners();
    }
    else{
      circularBarAllPostsShow = 0;
      successFetchBlogPost = 0;
      notifyListeners();
    }
  }

}