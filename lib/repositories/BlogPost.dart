import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:blogtalk/repositories/UserRegLogin.dart';
import 'package:blogtalk/models/BlogPost.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../config.dart';
import '../screens/user_reg_login/login_screen.dart';
import '../utils/constants.dart';
import '../utils/prefs.dart';

class BlogPost {
  Future<int?> uploadPost(String title, String content, int topic, File? coverImg) async {
    String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;

      try{
        var response;
        if(coverImg == null){
          print("111");
          String reqBody = json.encode(
              {
                "title": title,
                "content": content,
                "topic": topic
              }
          );
          response = await http.post(
              Uri.parse("$baseUrl/blogPost"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                "Authorization": "Bearer $accessToken",
              },
              body: reqBody
          );

          print("222");
          log(response.body);
        }
        else{
          var request = http.MultipartRequest('POST', Uri.parse("$baseUrl/blogPost"));
          request.files.add(await http.MultipartFile.fromPath('image', coverImg.path));

          request.headers["Authorization"] = "Bearer $accessToken";
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
        print("333");
        log(e.toString());
        return 0;
      }

  }

  Future<List<BlogPostModel>?> getUserAllPosts() async {
    try{
      String accessToken = Prefs.getInstance().getString(ACCESS_TOKEN)!;
      var response = await http.get(
          Uri.parse("$baseUrl/blogPost"),
          headers: {"Authorization": "Bearer $accessToken"}
      );

      if(response.statusCode == 200){
        print("done");
        var body = jsonDecode(response.body);

        List<BlogPostModel> blogPosts = [];
        for(int i = 0; i < body["result"].length; i++){
          blogPosts.add(BlogPostModel.fromJson(body["result"][i]));
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

}