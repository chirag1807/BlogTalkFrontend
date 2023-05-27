import 'package:blogtalk/providers/UserProfileSettingProvider.dart';
import 'package:blogtalk/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../providers/blogUtilitiesProvider.dart';
import '../../utils/widgets.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({Key? key}) : super(key: key);

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  Widget build(BuildContext context) {
    double w = getWidth(context);
    double h = getHeight(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProfileSettingProvider()),
        ChangeNotifierProvider(create: (context) => BlogUtilitiesProvider())
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: text("Followers", 20, FontWeight.w700, themeColorWhite, TextDecoration.none, TextAlign.center),
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
            padding: const EdgeInsets.all(10.0),
            child: Consumer<UserProfileSettingProvider>(
              builder: (context, provider, child){
                if(provider.circularBarFollowerFollowingShow == 1){
                  Future.microtask(() => provider.fetchFollowers());
                }
                return
                  provider.circularBarFollowerFollowingShow == 1?
                  const Center(child: CircularProgressIndicator(color: themeColorWhite,),) :
                  provider.circularBarFollowerFollowingShow == 0 ?
                  (
                  provider.successFetchFollowersFollowings == 2 ?
                      Center(
                        child: text("You don't have any followers yet...", 17, FontWeight.w500,
                            themeColorWhite, TextDecoration.none, TextAlign.justify),
                      ) :
                  provider.successFetchFollowersFollowings == 1 ?
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: provider.followers?.length ?? 0,
                        itemBuilder: (context, index){
                          return Row(
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
                                          gradient: provider.followers![index].user!.image == "" ? appBodyGradient() : const LinearGradient(colors: [themeColorWhite, themeColorWhite])
                                      ),
                                      alignment: Alignment.center,
                                      child: provider.followers![index].user!.image == "" ?
                                      text(getFirstCharacters(provider.followers![index].user!.name ?? ""), 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center)
                                          : Image.network(provider.followers![index].user!.image ?? "", fit: BoxFit.cover,),
                                    ),
                                  ),
                                  const SizedBox(width: 5.0,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      provider.followers![index].user!.name!.length > 20 ?
                                      text("${provider.followers![index].user!.name![17]}...", 16, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.justify) :
                                      text(provider.followers![index].user!.name ?? "", 16, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.justify),

                                      provider.followers![index].user!.bio!.length > 20 ?
                                      text("${provider.followers![index].user!.bio![17]}...", 14, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.justify) :
                                      text(provider.followers![index].user!.bio ?? "", 14, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.justify),
                                    ],
                                  )
                                ],
                              ),
                              Consumer<BlogUtilitiesProvider>(
                                  builder: (context, provider1, child){
                                    if(provider1.initialList == 0){
                                      print("yes ${provider1.followingOrNotList}");
                                      provider1.followingOrNotList?.clear();
                                      for(int i = 0; i < provider.followers!.length; i++){
                                        provider1.followingOrNotList?.add(provider.followers![i].isFollowing ?? 0);
                                      }
                                    }
                                    return InkWell(
                                      onTap: (){
                                        provider1.changeFollowingInList(index);
                                        provider.followers![index].isFollowing = provider.followers![index].isFollowing == 0 ? 1 : 0;
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
                          );
                        },
                        separatorBuilder: (context, index){
                          return const SizedBox(height: 12.0,);
                        },
                      ) :
                      Center(child: text(errorMsg, 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),)
                  ) :
                  Center(child: text(errorMsg, 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center));
              },
            ),
          ),
        ),
      ),
    );
  }
}

String getFirstCharacters(String input) {
  List<String> words = input.split(' ');

  if (words.length > 1) {
    return '${words[0][0]}${words[1][0]}';
  } else {
    return words[0][0];
  }
}