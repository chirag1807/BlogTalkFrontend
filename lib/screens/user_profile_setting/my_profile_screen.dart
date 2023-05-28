import 'package:blogtalk/providers/BottomNavIndexChangeProvider.dart';
import 'package:blogtalk/screens/blog_posts/edit_draft_blog_screen.dart';
import 'package:blogtalk/screens/user_profile_setting/edit_profile_screen.dart';
import 'package:blogtalk/screens/user_profile_setting/followers_screen.dart';
import 'package:blogtalk/screens/user_profile_setting/following_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../helper/draftPost.dart';
import '../../helper/getFirstCharOfName.dart';
import '../../helper/yourPost.dart';
import '../../providers/UserProfileScreenProvider.dart';
import '../../utils/constants.dart';
import '../../utils/widgets.dart';
import '../blog_posts/read_blog_screen1.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  List<String> navItems = [
    "Your Posts",
    "Your Drafts",
  ];

  @override
  Widget build(BuildContext context) {
    double w = getWidth(context);
    double h = getHeight(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProfileScreenProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavIndexChangeProvider()),
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text("Your Profile", 20, FontWeight.w700, themeColorWhite, TextDecoration.none, TextAlign.center),
                Consumer<UserProfileScreenProvider>(
                  builder: (context, provider, child){
                  return SizedBox(
                    width: w * 0.20,
                    child: InkWell(
                        onTap: (){
                          if(provider.successFetchUserData == 1){
                            Get.to(() => EditProfileScreen(name: provider.userData!.name ?? "", bio: provider.userData!.bio ?? "",
                              image: provider.userData!.image ?? "",),
                                transition: Transition.upToDown);
                          }
                        },
                        child: SvgPicture.asset("assets/images/edit_profile_icon.svg")),
                  );
                  }
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
        body: SafeArea(
          child: Container(
            width: w,
            height: h,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                gradient: appBodyGradient()
            ),
            child: Consumer<UserProfileScreenProvider>(
              builder: (context, provider, child){
                if(provider.circularBarShow == 1){
                  print("1");
                  Future.microtask(() => provider.fetchUserData());
                  print("2");
                }
              return provider.circularBarShow == 1 ?
                  const Center(child: CircularProgressIndicator(color: themeColorWhite,),) :
                  provider.circularBarShow == 0 ?
                  (
                    provider.successFetchUserData ==  1 ?
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: themeColorBlue,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: provider.userData!.image != "" ?
                                  Image.network(provider.userData!.image ?? "", fit: BoxFit.cover,) :
                                  text(GetFirstCharOfName().getFirstCharacters(provider.userData!.name ?? ""), 25, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center),
                                ),
                                const SizedBox(width: 8.0,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    text(provider.userData!.name ?? "", 20, FontWeight.w600, themeColorWhite, TextDecoration.none, TextAlign.center),
                                    const SizedBox(height: 3.0,),
                                    text(provider.userData!.bio ?? "", 16, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center)
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 25,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    text("Posts     ", 17, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center),
                                    text(provider.userData!.postsCount.toString(), 22, FontWeight.w600, themeColorWhite, TextDecoration.none, TextAlign.center),
                                  ],
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.to(() => const FollowersScreen(), transition: Transition.leftToRight);
                                  },
                                  child: Column(
                                    children: [
                                      text("Followers ", 17, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center),
                                      text(provider.userData!.followersCount.toString(), 22, FontWeight.w600, themeColorWhite, TextDecoration.none, TextAlign.center),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.to(() => const FollowingScreen(), transition: Transition.leftToRight);
                                  },
                                  child: Column(
                                    children: [
                                      text("Followings", 17, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center),
                                      text(provider.userData!.followingsCount.toString(), 22, FontWeight.w600, themeColorWhite, TextDecoration.none, TextAlign.center),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 50,),
                            Consumer<BottomNavIndexChangeProvider>(
                                builder: (context, provider1, child){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      for(int i=0 ; i< navItems.length; i++)
                                        InkWell(
                                          onTap: () {
                                            provider1.changeIndex(i);
                                          },
                                          child: text(navItems[i], 17,  provider1.myIndex == i ? FontWeight.w500 : FontWeight.w300, themeColorWhite,
                                              provider1.myIndex == i ? TextDecoration.underline : TextDecoration.none, TextAlign.center),
                                        )
                                    ],
                                  );
                                }
                            ),
                            const SizedBox(height: 25,),

                            Consumer<BottomNavIndexChangeProvider>(
                              builder: (context, provider1, child){
                                if(provider1.myIndex == 0){
                                  if(provider1.circularBarAllPostsShow == 1){
                                    print("yes");
                                    Future.microtask(() => provider1.fetchUserAllPosts());
                                  }
                                }
                                else{
                                  if(provider1.circularBarShowAllParticularSavePost == 1){
                                    Future.microtask(() => provider1.getAllPosts());
                                  }
                                }

                                return
                                //for posts
                                  provider1.myIndex == 0 ?
                                    (
                                    provider1.circularBarAllPostsShow == 1 ?

                                    const Center(child: CircularProgressIndicator(color: themeColorWhite,),) :

                                    (
                                        provider1.successFetchAllPosts == 2 ?
                                        Center(
                                          child: text("You've not post the blog in past...", 17,
                                              FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                                        ) :
                                        provider1.successFetchAllPosts == 1 ?
                                        Container(
                                          constraints: const BoxConstraints(
                                            maxHeight: 450.0,
                                          ),
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            itemCount: provider1.allPosts!.length,
                                            itemBuilder: (context, index){
                                              return InkWell(
                                                onTap: (){
                                                  Get.to(() => ReadBlogScreen1(blogId: provider1.allPosts![index].id ?? "",
                                                      topic: provider1.topicNameIds![provider1.allPosts![index].topic] ?? "", indicator: 0));
                                                },
                                                onLongPress: (){
                                                  showDialog(context: context, builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text('Delete Post'),
                                                      content: const Text('Are you sure to want to delete this post?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: const Text('No'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            provider1.deleteUserPost(index);
                                                            Navigator.pop(context);
                                                          },
                                                          child: const Text('Yes'),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                                },
                                                child: yourPost(
                                                    w,
                                                    h,
                                                    provider1.allPosts![index].title ?? "",
                                                    provider1.allPosts![index].image ?? "",
                                                    provider1.topicNameIds![provider1.allPosts![index].topic] ?? "    ",
                                                    provider1.allPosts![index].readMinute ?? 1,
                                                    provider1.allPosts![index].publishedAt ?? ""
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index){
                                              return const SizedBox(height: 5.0,);
                                            },
                                          ),
                                        )
                                        : Center(child: text(errorMsg, 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                                        )
                                    )

                                    ) :

                                      //for drafts
                                    provider1.myIndex == 1 ?
                                    (
                                    provider1.circularBarShowAllParticularSavePost == 1 ?

                                    const Center(child: CircularProgressIndicator(color: themeColorWhite,),) :
                                    (
                                    provider1.successFetchAllParticularSavePost == 1 ?

                                        ListView.separated(
                                          shrinkWrap: true,
                                          itemCount: provider1.savedDraftPosts!.length,
                                          itemBuilder: (context, index){
                                            return InkWell(
                                              onTap: (){
                                                Get.to(() => EditDraftBlogScreen(
                                                    id: provider1.savedDraftPosts![index].id,
                                                    title: provider1.savedDraftPosts![index].title,
                                                    content: provider1.savedDraftPosts![index].content,
                                                    topic: provider1.savedDraftPosts![index].topic,
                                                    coverImg: provider1.savedDraftPosts![index].coverImg)
                                                );
                                              },
                                              onLongPress: (){
                                                showDialog(context: context, builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text('Delete Draft Post'),
                                                    content: const Text('Are you sure to want to delete this post?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text('No'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          provider1.deleteParticularPost(provider1.savedDraftPosts![index].id, index);
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text('Yes'),
                                                      ),
                                                    ],
                                                  );
                                                });
                                              },
                                              child: draftPost(
                                                w,
                                                h,
                                                provider1.savedDraftPosts![index].title,
                                                provider1.savedDraftPosts![index].coverImg,
                                                provider1.topicNameIds![provider1.savedDraftPosts![index].topic] ?? "    ",
                                                provider1.savedDraftPosts![index].readMinute,
                                                provider1.savedDraftPosts![index].date,
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index){
                                            return const SizedBox(height: 12,);
                                          },
                                        ) :
                                    provider1.successFetchAllParticularSavePost == 2 ?
                                        Padding(
                                            padding: const EdgeInsets.only(top: 15.0),
                                            child: text("Your Draft is Empty", 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.justify)) :
                                        text(errorMsg, 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.justify)
                                    )
                                    ) //myIndex == 2
                                    : const SizedBox(height: 0,);
                              },
                            ),

                            const SizedBox(height: 25,),

                            const Divider(thickness: 2.0, color: themeColorWhite,),

                            const SizedBox(height: 25,),

                            Consumer<BottomNavIndexChangeProvider>(
                              builder: (context, provider1, child){
                                if(provider1.initialIndicator == 0){
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    provider1.setInitState(provider.userData!.sendEmail ?? true, provider.userData!.sendNotification ?? true);
                                  });
                                }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  text("Send Emails:", 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.start),
                                  Switch(value: provider1.emailState, onChanged: (value){
                                    provider1.changeState(value, 0);
                                  },
                                    activeColor: themeColorWhite,
                                    activeTrackColor: themeColorSnackBarGreen,
                                    inactiveThumbColor: themeColorWhite,
                                    inactiveTrackColor: themeColorHint1,
                                  )
                                ],
                              );
                              }
                            ),

                            const SizedBox(height: 5,),

                            Consumer<BottomNavIndexChangeProvider>(
                              builder: (context, provider1, child){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  text("Send Notifications:", 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.start),
                                  Switch(value: provider1.notificationState, onChanged: (value){
                                    provider1.changeState(value, 1);
                                  },
                                    activeColor: themeColorWhite,
                                    activeTrackColor: themeColorSnackBarGreen,
                                    inactiveThumbColor: themeColorWhite,
                                    inactiveTrackColor: themeColorHint1,
                                  )
                                ],
                              );
                              }
                            ),
                          ],
                        ),
                      ) :
                    Center(child: text(errorMsg, 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.justify),)
                  ) :
                Center(child: text(errorMsg, 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.justify),);

              }
            ),
          ),
        ),
      )
    );
  }
}


// ListView.builder(
// shrinkWrap: true,
// scrollDirection: Axis.horizontal,
// itemCount: navItems.length,
// itemBuilder: (context, index){
// return InkWell(
// onTap: (){
// provider.changeIndex(index);
// },

// );
// },
// );