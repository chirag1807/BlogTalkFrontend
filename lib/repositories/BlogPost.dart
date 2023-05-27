import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:blogtalk/repositories/UserRegLogin.dart';
import 'package:blogtalk/models/BlogPost.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../config.dart';
import '../models/BlogPostWithAuthor.dart';
import '../models/UserAllPost.dart';
import '../screens/user_reg_login/login_screen.dart';
import '../utils/constants.dart';
import '../utils/prefs.dart';

class BlogPost {
  Future<int?> uploadPost(String id, String title, String content, int topic, File? coverImg, int indicator) async {
    //indicator = 0 => upload, indicator = 1 => update
    String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;

      try{
        var response;
        if(coverImg == null){

          String reqBody = indicator == 0 ?
          json.encode(
              {
                "title": title,
                "content": content,
                "topic": topic
              }
          ) : json.encode(
            {
              "id": id,
              "title": title,
              "content": content,
              "topic": topic
            }
          );

          var headers = {
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer $accessToken",
          };

          if(indicator == 0){
            response = await http.post(
                Uri.parse("$baseUrl/blogPost"),
                headers: headers,
                body: reqBody
            );
          }
          else{
            response = await http.patch(
                Uri.parse("$baseUrl/blogPost"),
                headers: headers,
                body: reqBody
            );
          }

          log(response.body);
        }
        else{
          var request = http.MultipartRequest(indicator == 0 ? 'POST' : 'PATCH', Uri.parse("$baseUrl/blogPost"));
          request.files.add(await http.MultipartFile.fromPath('image', coverImg.path));

          request.headers["Authorization"] = "Bearer $accessToken";
          if(indicator == 1){
            request.fields['id'] = id;
          }
          request.fields['title'] = title;
          request.fields['content'] = content;
          request.fields['topic'] = topic.toString();

          response = await request.send();

        }

        if(response.statusCode == 200){
          print("done");
          return 1;
        }
        else if(response.statusCode == 401){
          int? a = await UserRegLogin().resetToken();
          if(a != 1){
            Get.offAll(() => const LoginScreen(indicator: 0,));
          }
          else{
            return 0;
          }
        }
        else{
          return 0;
        }

      } catch(e) {
        log(e.toString());
        return 0;
      }

  }

  Future<List<UserAllPost>?> getUserAllPosts() async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.get(
          Uri.parse("$baseUrl/blogPost"),
          headers: {"Authorization": "Bearer $accessToken"}
      );

      if(response.statusCode == 200){
        print("done");
        var body = jsonDecode(response.body);

        List<UserAllPost> blogPosts = [];
        for(int i = 0; i < body["result"].length; i++){
          blogPosts.add(UserAllPost.fromJson(body["result"][i]));
          print(blogPosts[i].topic);
        }

        return blogPosts;
      }
      else if(response.statusCode == 204){
        return [];
      }
      else if(response.statusCode == 401){
        int? a = await UserRegLogin().resetToken();
        if(a != 1){
          Get.offAll(() => const LoginScreen(indicator: 0,));
        }
        else{
          return null;
        }
      }
      else{
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<BlogPostModel?> getParticularPost(String id) async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.get(
          Uri.parse("$baseUrl/blogPost/particular"),
          headers: {"Authorization": "Bearer $accessToken", "id": id}
      );

      log(response.body);

      if(response.statusCode == 200){
        print("done");
        var body = jsonDecode(response.body);

        BlogPostModel blogPost = BlogPostModel.fromJson(body["result"]);

        return blogPost;
      }
      else if(response.statusCode == 401){
        int? a = await UserRegLogin().resetToken();
        if(a != 1){
          Get.offAll(() => const LoginScreen(indicator: 0,));
        }
        else{
          return null;
        }
      }
      else{
        return null;
      }

    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> updateBlogViews(String id) async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.patch(
        Uri.parse("$baseUrl/blogPost/incrView"),
        headers: {"Authorization": "Bearer $accessToken", 'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode(
          {
            "id": id
          }
        )
      );

      if(response.statusCode == 200){
        log(response.body);
      }
      else if(response.statusCode == 401){
        int? a = await UserRegLogin().resetToken();
        if(a != 1){
          Get.offAll(() => const LoginScreen(indicator: 0,));
        }
        else{
          print(a);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateBlogLike(String id) async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.patch(
          Uri.parse("$baseUrl/blogPost/updateLike"),
          headers: {"Authorization": "Bearer $accessToken", 'Content-Type': 'application/json; charset=UTF-8',},
          body: json.encode(
              {
                "id": id
              }
          )
      );

      if(response.statusCode == 200){
        log(response.body);
      }
      else if(response.statusCode == 401){
        int? a = await UserRegLogin().resetToken();
        if(a != 1){
          Get.offAll(() => const LoginScreen(indicator: 0,));
        }
        else{
          print(a);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addToSave(String blogId) async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.post(
          Uri.parse("$baseUrl/savePost"),
          headers: {"Authorization": "Bearer $accessToken", 'Content-Type': 'application/json; charset=UTF-8',},
          body: json.encode(
              {
                "blogId": blogId
              }
          )
      );

      if(response.statusCode == 200){
        log(response.body);
      }
      else if(response.statusCode == 401){
        int? a = await UserRegLogin().resetToken();
        if(a != 1){
          Get.offAll(() => const LoginScreen(indicator: 0,));
        }
        else{
          print(a);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<BlogPostWithAuthor>?> getSavedPosts() async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.get(
          Uri.parse("$baseUrl/savePost"),
          headers: {"Authorization": "Bearer $accessToken"}
      );

      if(response.statusCode == 200){
        print("done");
        var body = jsonDecode(response.body);

        List<BlogPostWithAuthor> blogPosts = [];
        for(int i = 0; i < body["result"].length; i++){
          blogPosts.add(BlogPostWithAuthor.fromJson(body["result"][i]));
          print(blogPosts[i].topic);
        }
        return blogPosts;
      }
      else if(response.statusCode == 204){
        return [];
      }
      else if(response.statusCode == 401){
        int? a = await UserRegLogin().resetToken();
        if(a != 1){
          Get.offAll(() => const LoginScreen(indicator: 0,));
        }
        else{
          return null;
        }
      }
      else{
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> removeFromSave(String blogId) async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.delete(
          Uri.parse("$baseUrl/savePost"),
          headers: {"Authorization": "Bearer $accessToken", 'Content-Type': 'application/json; charset=UTF-8',},
          body: json.encode(
              {
                "blogId": blogId
              }
          )
      );

      if(response.statusCode == 200){
        log(response.body);
      }
      else if(response.statusCode == 401){
        int? a = await UserRegLogin().resetToken();
        if(a != 1){
          Get.offAll(() => const LoginScreen(indicator: 0,));
        }
        else{
          print(a);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deletePost(String blogId) async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.delete(
          Uri.parse("$baseUrl/blogPost"),
          headers: {"Authorization": "Bearer $accessToken", 'Content-Type': 'application/json; charset=UTF-8',},
          body: json.encode(
              {
                "id": blogId
              }
          )
      );

      if(response.statusCode == 200){
        log(response.body);
      }
      else if(response.statusCode == 401){
        int? a = await UserRegLogin().resetToken();
        if(a != 1){
          Get.offAll(() => const LoginScreen(indicator: 0,));
        }
        else{
          print(a);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

}