import 'package:blogtalk/providers/blogTtsProvider.dart';
import 'package:blogtalk/providers/readBlogProvider.dart';
import 'package:blogtalk/repositories/followerFollowings.dart';
import 'package:blogtalk/screens/blog_posts/edit_blog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../providers/blogUtilitiesProvider.dart';
import '../../repositories/BlogPost.dart';
import '../../utils/constants.dart';
import '../../utils/widgets.dart';

class ReadBlogScreen1 extends StatefulWidget {
  final String blogId;
  final String topic;
  final int indicator;
  //indicator = 0 , published by you , can edit
  //indicator = 1 , published not by you , can read
  const ReadBlogScreen1({Key? key, required this.blogId, required this.topic, required this.indicator}) : super(key: key);

  @override
  State<ReadBlogScreen1> createState() => _ReadBlogScreen1State();
}

class _ReadBlogScreen1State extends State<ReadBlogScreen1> with WidgetsBindingObserver {

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  // }
  //
  // @override
  // void dispose() async {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  //   await BlogPost().updateBlogViews(widget.blogId);
  // }
  //
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   if (state == AppLifecycleState.paused) {
  //     await BlogPost().updateBlogViews(widget.blogId);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double w = getWidth(context);
    double h = getHeight(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BlogTTSProvider()),
          ChangeNotifierProvider(create: (context) => ReadBlogProvider()),
          ChangeNotifierProvider(create: (context) => BlogUtilitiesProvider()),
        ],
        child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              text("BlogTalk", 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.start),
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
              child: Consumer<ReadBlogProvider>(
                builder: (context, provider, child){
                  if(provider.circularBarAllPostsShow == 1){
                    Future.microtask(() => provider.fetchBlogPost(widget.blogId));
                  }
                  return
                    provider.circularBarAllPostsShow == 1 ?
                  const Center(child: CircularProgressIndicator(color: themeColorWhite,),) :
                  provider.circularBarAllPostsShow == 0 ? (
                  provider.successFetchBlogPost == 1 ?
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Title : ${provider.blogPost!.title}", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.justify),
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
                            text("${provider.blogPost!.topic} min read", 15, FontWeight.w400,
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
                          child: provider.blogPost!.coverImage == "" ?
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.photo, color: themeColorWhite, size: 100,),
                              const SizedBox(height: 5.0,),
                              text("No Cover photo", 12, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center)
                            ],
                          ) : Image.network(provider.blogPost!.coverImage ?? "", fit: BoxFit.cover,),
                        ),
                        const SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Consumer<BlogUtilitiesProvider>(
                                  builder: (context, provider1, child){
                                    if(provider1.initialLike == 0){
                                      provider1.liked = provider.blogPost!.likedOrNot ?? 0;
                                      provider1.likeCount = provider.blogPost!.noOfLikes ?? 0;
                                    }
                                  return InkWell(
                                      onTap: () async {
                                        provider1.changeLikeIcon(provider1.liked == 0 ? 1 : 0, provider1.liked == 0 ? 1 : -1);
                                        await BlogPost().updateBlogLike(widget.blogId);
                                      },
                                      child:
                                       provider1.liked == 0 ? SvgPicture.asset("assets/images/like_blog.svg", width: 25, height: 25,)
                                           : SvgPicture.asset("assets/images/liked_blog.svg", width: 25, height: 25,)
                                    );
                                  }
                                ),
                                const SizedBox(width: 5.0,),
                                Consumer<BlogUtilitiesProvider>(
                                    builder: (context, provider1, child){
                                    return text(provider1.likeCount.toString(), 12, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center);
                                    }
                                ),
                                const SizedBox(width: 12.0,),
                                SvgPicture.asset("assets/images/views_of_blog.svg", width: 25, height: 25,),
                                const SizedBox(width: 5.0,),
                                text(provider.blogPost!.noOfViews.toString(), 12, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center),
                              ],
                            ),
                            Row(
                              children: [
                                Consumer<BlogTTSProvider>(
                                    builder: (context, provider1, child){

                                      return InkWell(
                                          onTap: (){
                                            provider1.toggleTts(provider.blogPost!.content ?? "");
                                          },
                                          child: SvgPicture.asset(
                                            provider1.isPlaying() ? "assets/images/pause_blog.svg" : "assets/images/play_blog.svg",
                                            width: 25, height: 25,));
                                    }
                                ),
                                const SizedBox(width: 15.0,),
                                Consumer<BlogUtilitiesProvider>(
                                    builder: (context, provider1, child){
                                      if(provider1.initialSavedOrNot == 0){
                                        provider1.savedOrNot = provider.blogPost!.savedOrNot ?? 0;
                                      }
                                    return InkWell(
                                        onTap: () async {
                                          provider1.savedOrNot == 0 ? await BlogPost().addToSave(widget.blogId)
                                              : await BlogPost().removeFromSave(widget.blogId);
                                          provider1.changeSaveToPost(provider1.savedOrNot == 0 ? 1 : 0);
                                        },
                                        child: provider1.savedOrNot == 0 ?
                                        SvgPicture.asset("assets/images/saved_posts_icon.svg", width: 25, height: 25,) :
                                        SvgPicture.asset("assets/images/saved_posts_done_icon.svg", width: 25, height: 25,)
                                    );
                                    }),
                                const SizedBox(width: 15.0,),
                                widget.indicator == 0 ? IconButton(onPressed: (){
                                  Get.to(() => EditBlogScreen(blog: provider.blogPost!));
                                }, icon: const Icon(Icons.edit_note, color: themeColorWhite, size: 35,))
                                    : const SizedBox(),
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
                            builder: (context, provider1, child){
                              return text(provider.blogPost!.content ?? errorMsg, 17, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.justify);
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
                                .parse(provider.blogPost!.publishedAt!)), 17, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.justify),
                            const SizedBox(height: 25.0,),
                            text("Published By :", 18, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.start),
                            const SizedBox(height: 10.0,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                          gradient: provider.blogPost!.author!.image == "" ? appBodyGradient() : const LinearGradient(colors: [themeColorWhite, themeColorWhite])
                                      ),
                                      alignment: Alignment.center,
                                      child: provider.blogPost!.author!.image == "" ?
                                      text(getFirstCharacters(provider.blogPost!.author!.name ?? ""), 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center)
                                          : Image.network(provider.blogPost!.author!.image ?? "", fit: BoxFit.cover,),
                                    ),
                                    const SizedBox(width: 5.0,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        text(provider.blogPost!.author!.name ?? "", 17, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.justify),
                                        text(provider.blogPost!.author!.bio ?? "", 16, FontWeight.w300, themeColorWhite, TextDecoration.none, TextAlign.justify),
                                      ],
                                    )
                                  ],
                                ),
                                Consumer<BlogUtilitiesProvider>(
                                  builder: (context, provider1, child){
                                    if(provider1.initialFollowingOrNot == 0){
                                      provider1.followingOrNot = provider.blogPost!.followingOrNot ?? 0;
                                    }
                                  return InkWell(
                                    onTap: () async {
                                      await FollowerFollowings().updateFollowerFollowings(provider.blogPost!.author!.sId!,
                                          provider.blogPost!.author!.followings!, provider.blogPost!.author!.followers!,
                                          provider1.followingOrNot);
                                      provider1.changeFollowing(provider1.followingOrNot == 0 ? 1 : 0);
                                      print(provider1.followingOrNot);
                                    },
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        gradient: appBodyGradient(),
                                        border: Border.all(color: themeColorWhite),
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          provider1.followingOrNot == 0 ?
                                          text("Follow", 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center)
                                          : text("Following", 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                                          const SizedBox(width: 4.0,),
                                          provider1.followingOrNot == 0 ?
                                          SvgPicture.asset("assets/images/follow_icon.svg", width: 20, height: 20,)
                                          : SvgPicture.asset("assets/images/following_icon.svg", width: 20, height: 20,),
                                        ],
                                      ),
                                    ),
                                  );
                                  }
                                )
                              ],
                            ),
                          ],
                        )
                        // : const SizedBox(),
                      ],
                    ),
                  ) :
                  Center(child: text(errorMsg, 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.justify),)
                  ) :
                  Container();
                },
              )
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
    return '${words[0][0]}${words[1][0]}';
  } else {
    return words[0][0];
  }
}