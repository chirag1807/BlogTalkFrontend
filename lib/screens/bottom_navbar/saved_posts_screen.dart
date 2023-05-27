import 'package:blogtalk/providers/blogUtilitiesProvider.dart';
import 'package:blogtalk/screens/user_profile_setting/my_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/BottomNavIndexChangeProvider.dart';
import '../../utils/constants.dart';
import '../../utils/widgets.dart';
import '../blog_posts/read_blog_screen1.dart';

class SavedPostsScreen extends StatefulWidget {
  const SavedPostsScreen({Key? key}) : super(key: key);

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen> {
  @override
  Widget build(BuildContext context) {
    double w = getWidth(context);
    double h = getHeight(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavIndexChangeProvider()),
        ChangeNotifierProvider(create: (context) => BlogUtilitiesProvider())
      ],
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
                text("Saved Blogs", 20, FontWeight.w700, themeColorWhite, TextDecoration.none, TextAlign.center),
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
              print("hello called again");
              if(provider.circularBarSavedPostsShow == 1){
                Future.microtask(() => provider.fetchUserSavedPosts());
              }
              return
              provider.circularBarSavedPostsShow == 1?
              const Center(child: CircularProgressIndicator(color: themeColorWhite,),) :
              provider.circularBarSavedPostsShow == 0 ?
              (
                  provider.successFetchSavedPosts == 2 ?
                  Center(
                    child: Column(
                      children: [
                        text("You've not saved any blog in past...", 17,
                            FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                        const SizedBox(height: 5.0,),
                        text("Explore blogs and save your first blog.", 15,
                            FontWeight.w500, themeColorGreen, TextDecoration.none, TextAlign.center),
                      ],
                    ),
                  ) :
                  provider.successFetchSavedPosts == 1 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text("Here are your Saved Blogs...", 20,
                          FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                      const SizedBox(height: 20.0,),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: provider.savedPosts!.length,
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: (){
                                print("hey ${provider.savedPosts![index].followingOrNot}");
                                // Get.to(() => ReadBlogScreen1(blogId: provider.savedPosts![index].id ?? "",
                                //     topic: provider.topicNameIds![provider.savedPosts![index].topic] ?? "", indicator: 0));
                              },
                              child: Container(
                                width: w,
                                height: h * 0.20,
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
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ClipOval(
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: themeColorGreen),
                                                    gradient: provider.savedPosts![index].author!.image == "" ? appBodyGradient() : const LinearGradient(colors: [themeColorWhite, themeColorWhite])
                                                ),
                                                alignment: Alignment.center,
                                                child: provider.savedPosts![index].author!.image == "" ?
                                                text(getFirstCharacters(provider.savedPosts![index].author!.name ?? ""), 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center)
                                                    : Image.network(provider.savedPosts![index].author!.image ?? "", fit: BoxFit.cover,),
                                              ),
                                            ),
                                            const SizedBox(width: 5.0,),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                provider.savedPosts![index].author!.name!.length > 20 ?
                                                text("${provider.savedPosts![index].author!.name![17]}...", 16, FontWeight.w500, themeColorBlack, TextDecoration.none, TextAlign.justify) :
                                                text(provider.savedPosts![index].author!.name ?? "", 16, FontWeight.w500, themeColorBlack, TextDecoration.none, TextAlign.justify),

                                                provider.savedPosts![index].author!.bio!.length > 20 ?
                                                text("${provider.savedPosts![index].author!.bio![17]}...", 14, FontWeight.w400, themeColorBlack, TextDecoration.none, TextAlign.justify) :
                                                text(provider.savedPosts![index].author!.bio ?? "", 14, FontWeight.w400, themeColorBlack, TextDecoration.none, TextAlign.justify),
                                              ],
                                            )
                                          ],
                                        ),
                                        Consumer<BlogUtilitiesProvider>(
                                          builder: (context, provider1, child){
                                            if(provider1.initialList == 0){
                                              print(provider1.followingOrNotList.toString());
                                              provider1.followingOrNotList?.clear();
                                              for(int i = 0; i < provider.savedPosts!.length; i++){
                                                provider1.followingOrNotList?.add(provider.savedPosts![i].followingOrNot ?? 0);
                                              }
                                            }
                                          return InkWell(
                                            onTap: (){
                                              provider1.changeFollowingInList(index);
                                              provider.savedPosts![index].followingOrNot = provider.savedPosts![index].followingOrNot == 0 ? 1 : 0;
                                            },
                                            child: Container(
                                              height: 35,
                                              padding: const EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                gradient: appBodyGradient(),
                                                border: Border.all(color: themeColorWhite),
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [

                                                  provider1.followingOrNotList![index] == 0 ?
                                                  text("Follow", 15, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center)
                                                      : text("Following", 15, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                                                  const SizedBox(width: 4.0,),
                                                  provider1.followingOrNotList![index] == 0 ?
                                                  SvgPicture.asset("assets/images/follow_icon.svg", width: 16, height: 16,)
                                                      : SvgPicture.asset("assets/images/following_icon.svg", width: 16, height: 16,),
                                                ],
                                              ),
                                            ),
                                          );
                                          }
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            child: overFlowText(provider.savedPosts![index].title!, 17, FontWeight.w500, themeColorBlack,
                                                TextDecoration.none, TextAlign.justify, 3, TextOverflow.ellipsis),
                                          ),
                                        ),
                                        const Expanded(flex: 1, child: SizedBox()),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: provider.savedPosts![index].image == "" ?
                                                themeColorWhite : themeColorGreen),
                                                borderRadius: BorderRadius.circular(2.0)
                                            ),
                                            child: provider.savedPosts![index].image == "" ?
                                            SvgPicture.asset("assets/images/empty_cover_image.svg")
                                                : Image.network(provider.savedPosts![index].image!),
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
                                              padding: const EdgeInsets.all(4.0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4.0),
                                                  gradient: appBodyGradient()
                                              ),
                                              alignment: Alignment.center,
                                              child: provider.topicNameIds != null ?
                                              text(provider.topicNameIds![provider.savedPosts![index].topic] ?? "    ", 14, FontWeight.w400,
                                                  themeColorWhite, TextDecoration.none, TextAlign.center) : text("    ", 14, FontWeight.w400,
                                                  themeColorWhite, TextDecoration.none, TextAlign.center),
                                            ),
                                            const SizedBox(width: 3.0,),
                                            text("${provider.savedPosts![index].readMinute} min read", 14, FontWeight.w400,
                                                themeColorBlack, TextDecoration.none, TextAlign.center)
                                          ],
                                        ),
                                        text(DateFormat("dd MMMM yyyy").format(DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                                            .parse(provider.savedPosts![index].publishedAt!)),
                                            14, FontWeight.w400, themeColorBlack, TextDecoration.none, TextAlign.center)
                                      ],
                                    )
                                  ],
                                ),
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
            },
          )
        ),
      ),
    );
  }
}
