import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

import '../screens/blog_posts/read_blog_screen1.dart';

class DynamicLink{

  Future<Uri> generateDynamicLink(String topic, String id, int indicator) async {
    String url = 'https://blogtalkapp.page.link';
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        link: Uri.parse('$url?blogId=$id&topic=$topic&indicator=$indicator'),
        uriPrefix: url,
        androidParameters: const AndroidParameters(
            packageName: 'com.example.blogtalk',
            minimumVersion: 0
        )
    );

    final ShortDynamicLink dynamicUrl = await FirebaseDynamicLinks.instance.buildShortLink(parameters);

    return dynamicUrl.shortUrl;
  }

  void handleDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLink) {
      int a = int.parse(dynamicLink.link.queryParameters['indicator'] ?? "1");
      Get.to(() => ReadBlogScreen1(
          blogId: dynamicLink.link.queryParameters['blogId'] ?? "",
          topic: dynamicLink.link.queryParameters['topic'] ?? "",
          indicator: a
      ));
    });
  }

}