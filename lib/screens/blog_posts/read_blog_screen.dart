import 'package:blogtalk/models/BlogPost.dart';
import 'package:blogtalk/providers/blogTtsProvider.dart';
import 'package:blogtalk/repositories/BlogPost.dart';
import 'package:blogtalk/utils/constants.dart';
import 'package:blogtalk/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReadBlogScreen extends StatefulWidget {
  final BlogPostModel blogPost;
  final String topic;
  final int indicator;
  //indicator = 0 , published by you , can edit
  //indicator = 1 , published not by you , can read
  const ReadBlogScreen({Key? key, required this.blogPost, required this.topic, required this.indicator}) : super(key: key);

  @override
  State<ReadBlogScreen> createState() => _ReadBlogScreenState();
}

class _ReadBlogScreenState extends State<ReadBlogScreen> {

  @override
  void dispose() async {
    super.dispose();
    await BlogPost().updateBlogViews(widget.blogPost.sId!);
  }

  @override
  Widget build(BuildContext context) {
    double w = getWidth(context);
    double h = getHeight(context);
    return ChangeNotifierProvider(
      create: (context) => BlogTTSProvider(),
      child: Scaffold(
        // backgroundColor: themeColorBlue,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              text("BlogTalk", 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.start),
              widget.indicator == 0 ? IconButton(onPressed: (){}, icon: const Icon(Icons.edit_note, color: themeColorWhite, size: 35,))
                  : const SizedBox()
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: appBodyGradient(),
                border: const Border(
                    bottom: BorderSide(
                        color: themeColorWhite,
                        width: 1.0
                    )
                )
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            width: w,
            height: h,
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            decoration: BoxDecoration(
              gradient: appBodyGradient()
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text("Title : ${widget.blogPost.title}", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.justify),
                  const SizedBox(height: 10.0,),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            gradient: appBodyGradient()
                        ),
                        alignment: Alignment.center,
                        child: text(widget.topic, 15, FontWeight.w400,
                            themeColorWhite, TextDecoration.none, TextAlign.center)
                      ),
                      const SizedBox(width: 7.0,),
                      text("${widget.blogPost.topic} min read", 15, FontWeight.w400,
                          themeColorWhite, TextDecoration.none, TextAlign.center)
                    ],
                  ),
                  const SizedBox(height: 18.0,),
                  Container(
                    width: w,
                    height: 240,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: themeColorWhite)
                    ),
                    child: widget.blogPost.coverImage == "" ?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.photo, color: themeColorWhite, size: 100,),
                            const SizedBox(height: 5.0,),
                            text("No Cover photo", 12, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center)
                          ],
                        ) : Image.network(widget.blogPost.coverImage ?? "", fit: BoxFit.cover,),
                  ),
                  const SizedBox(height: 15.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/images/like_blog.svg", width: 25, height: 25,),
                          const SizedBox(width: 5.0,),
                          text(widget.blogPost.noOfLikes.toString(), 12, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center),
                          const SizedBox(width: 12.0,),
                          SvgPicture.asset("assets/images/views_of_blog.svg", width: 25, height: 25,),
                          const SizedBox(width: 5.0,),
                          text(widget.blogPost.noOfViews.toString(), 12, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center),
                        ],
                      ),
                      Row(
                        children: [
                          Consumer<BlogTTSProvider>(
                            builder: (context, provider, child){

                            return InkWell(
                                onTap: (){
                                  provider.toggleTts(widget.blogPost.content ?? "");
                                },
                                child: SvgPicture.asset(
                                  provider.isPlaying() ? "assets/images/pause_blog.svg" : "assets/images/play_blog.svg",
                                  width: 25, height: 25,));
                            }
                          ),
                          const SizedBox(width: 15.0,),
                          SvgPicture.asset("assets/images/saved_posts_icon.svg", width: 25, height: 25,),
                          const SizedBox(width: 15.0,),
                          SvgPicture.asset("assets/images/mute_blog.svg", width: 25, height: 25,),
                          const SizedBox(width: 15.0,),
                          SvgPicture.asset("assets/images/share_blog.svg", width: 25, height: 25,),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 25.0,),
                  text("Content :", 18, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.start),
                  const SizedBox(height: 18.0,),
                  Consumer<BlogTTSProvider>(
                    builder: (context, provider, child){
                    return text(widget.blogPost.content ?? errorMsg, 17, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.justify);
                    }
                  ),

                  // widget.indicator == 1 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0,),
                      const Divider(color: themeColorWhite, thickness: 2.0,),
                      const SizedBox(height: 20.0,),

                      text("Published On :", 18, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.start),
                      const SizedBox(height: 10.0,),
                      text(DateFormat("dd MMMM yyyy").format(DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                          .parse(widget.blogPost.publishedAt!)), 17, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.justify),
                      const SizedBox(height: 25.0,),
                      text("Published By :", 18, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.start),
                      const SizedBox(height: 10.0,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: themeColorWhite),
                              gradient: widget.blogPost.author!.image == "" ? appBodyGradient() : const LinearGradient(colors: [themeColorWhite, themeColorWhite])
                            ),
                            alignment: Alignment.center,
                            child: widget.blogPost.author!.image == "" ?
                                text(getFirstCharacters(widget.blogPost.author!.name ?? ""), 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center)
                                : Image.network(widget.blogPost.author!.image ?? "", fit: BoxFit.cover,),
                          ),
                          const SizedBox(width: 5.0,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text(widget.blogPost.author!.name ?? "", 17, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.justify),
                              text(widget.blogPost.author!.bio ?? "", 16, FontWeight.w300, themeColorWhite, TextDecoration.none, TextAlign.justify),
                            ],
                          )

                        ],
                      ),
                    ],
                  )
                      // : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }

  // List<TextSpan> getTextSpans(BlogTTSProvider ttsProvider, String textToSpeak) {
  //   List<TextSpan> textSpans = [];
  //   List<String> spokenWords = ttsProvider.getSpokenWords();
  //   List<String> wordsToSpeak = textToSpeak.split(' ');
  //
  //   for (int i = 0; i < wordsToSpeak.length; i++) {
  //     TextSpan textSpan = TextSpan(
  //       text: wordsToSpeak[i] + ' ',
  //       style: TextStyle(
  //         color: spokenWords.contains(wordsToSpeak[i]) ? Colors.red : Colors.black,
  //       ),
  //     );
  //     textSpans.add(textSpan);
  //   }
  //
  //   return textSpans;
  // }
  //chatgpt => populate data in node.js

}

String getFirstCharacters(String input) {
  List<String> words = input.split(' ');

  if (words.length > 1) {
    // If there are more than one word, return the first character of the first two words
    return '${words[0][0]}${words[1][0]}';
  } else {
    // If there is only one word, return the first character
    return words[0][0];
  }
}