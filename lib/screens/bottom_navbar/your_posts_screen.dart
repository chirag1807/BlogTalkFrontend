import 'package:blogtalk/providers/BottomNavIndexChangeProvider.dart';
import 'package:blogtalk/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/widgets.dart';
import '../blog_posts/create_blog_screen.dart';
import '../user_profile_setting/my_profile_screen.dart';

class YourPostsScreen extends StatefulWidget {
  const YourPostsScreen({Key? key}) : super(key: key);

  @override
  State<YourPostsScreen> createState() => _YourPostsScreenState();
}

class _YourPostsScreenState extends State<YourPostsScreen> {
  @override
  Widget build(BuildContext context) {
    double w = getWidth(context);
    double h = getHeight(context);
    return ChangeNotifierProvider(
      create: (context) => BottomNavIndexChangeProvider(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text("Your Posts", 20, FontWeight.w700, themeColorWhite, TextDecoration.none, TextAlign.center),
                SizedBox(
                  width: w * 0.20,
                  child: InkWell(
                      onTap: (){
                        Get.to(() => const MyProfileScreen(), transition: Transition.upToDown);
                      },
                      child: SvgPicture.asset("assets/images/profile_icon.svg")),
                )
              ],
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: appBodyGradient(),
                border: const Border(
                    bottom: BorderSide(
                        color: themeColorWhite,
                        width: 2.0
                    )
                )
            ),
          ),
        ),
        body: Container(
          width: w,
          height: h,
          padding: const EdgeInsets.all(10.0),
          child: Consumer<BottomNavIndexChangeProvider>(
            builder: (context, provider, child){
              if(provider.circularBarAllPostsShow == 1){
                Future.microtask(() => provider.fetchUserAllPosts());
              }
              return
              provider.circularBarAllPostsShow == 1?
                  const Center(child: CircularProgressIndicator(color: themeColorWhite,),) :
              provider.circularBarAllPostsShow == 0 ?
              (
                  provider.successFetchAllPosts == 2 ?
                  Center(
                    child: Column(
                      children: [
                        text("You've not post the blog in past...", 17,
                            FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                        const SizedBox(height: 5.0,),
                        text("Tap below button to write your first blog.", 15,
                            FontWeight.w500, themeColorGreen, TextDecoration.none, TextAlign.center),
                      ],
                    ),
                  ) :
                  provider.successFetchAllPosts == 1 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text("Here are your Blogs...", 20,
                          FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                      const SizedBox(height: 20.0,),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: provider.allPosts!.length,
                          itemBuilder: (context, index){
                            return Container(
                              width: w,
                              height: h * 0.14,
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: themeColorWhite,
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          child: const Text("me tera ban paya hu jab se me mil jata hu tum se hi tum se hi  har waqt soch pata hu tum se hi", style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: themeColorBlack,
                                            decoration: TextDecoration.none,
                                            decorationThickness: 2.0,
                                          ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ),
                                      const Expanded(flex: 1, child: SizedBox()),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: provider.allPosts![index].coverImage == "" ?
                                            themeColorWhite : themeColorGreen),
                                            borderRadius: BorderRadius.circular(2.0)
                                          ),
                                          child: provider.allPosts![index].coverImage == "" ?
                                          SvgPicture.asset("assets/images/empty_cover_image.svg")
                                          : Image.network(provider.allPosts![index].coverImage!),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4.0),
                                              gradient: appBodyGradient()
                                            ),
                                            child: Center(
                                              child: text(provider.allPosts![index].topic.toString(), 14, FontWeight.w400,
                                                  themeColorWhite, TextDecoration.none, TextAlign.center),
                                            ),
                                          ),
                                          const SizedBox(width: 3.0,),
                                          text("${provider.allPosts![index].readMinute} min read", 14, FontWeight.w400,
                                              themeColorBlack, TextDecoration.none, TextAlign.center)
                                        ],
                                      ),
                                      text(DateFormat("dd MMMM yyyy").format(DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                                          .parse(provider.allPosts![index].publishedAt!)),
                                          14, FontWeight.w400, themeColorBlack, TextDecoration.none, TextAlign.center)
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index){
                            return const SizedBox(height: 5.0,);
                          },
                        ),
                      )
                    ],
                  ) : Center(child: text(errorMsg, 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                  )
              ) :
              Center(child: text(errorMsg, 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
              );
            }
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: (){
              Get.to(() => const CreateBlogScreen());
            },
            backgroundColor: const Color(0xCCFFFFFF),
            icon: SvgPicture.asset("assets/images/write_blog_icon.svg"),
            label: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return appBodyGradient().createShader(bounds);
              },
              child: const Text("Write Blog", style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500
              ),),
            )
        ),
      ),
    );
  }
}
