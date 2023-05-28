import 'package:blogtalk/providers/UserProfileSettingProvider.dart';
import 'package:blogtalk/providers/blogUtilitiesProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../helper/getFirstCharOfName.dart';
import '../../utils/constants.dart';
import '../../utils/widgets.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({Key? key}) : super(key: key);

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
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
            child: text("Followings", 20, FontWeight.w700, themeColorWhite, TextDecoration.none, TextAlign.center),
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
                  print("yes");
                  Future.microtask(() => provider.fetchFollowings());
                }
                return
                  provider.circularBarFollowerFollowingShow == 1?
                  const Center(child: CircularProgressIndicator(color: themeColorWhite,),) :
                  provider.circularBarFollowerFollowingShow == 0 ?
                  (
                      provider.successFetchFollowersFollowings == 2 ?
                      Center(
                        child: text("You are not following any author yet...", 17, FontWeight.w500,
                            themeColorWhite, TextDecoration.none, TextAlign.justify),
                      ) :
                      provider.successFetchFollowersFollowings == 1 ?
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: provider.followings?.length ?? 0,
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
                                          gradient: provider.followings![index].user!.image == "" ? appBodyGradient() : const LinearGradient(colors: [themeColorWhite, themeColorWhite])
                                      ),
                                      alignment: Alignment.center,
                                      child: provider.followings![index].user!.image == "" ?
                                      text(GetFirstCharOfName().getFirstCharacters(provider.followings![index].user!.name ?? ""), 17, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center)
                                          : Image.network(provider.followings![index].user!.image ?? "", fit: BoxFit.cover,),
                                    ),
                                  ),
                                  const SizedBox(width: 5.0,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      provider.followings![index].user!.name!.length > 20 ?
                                      text("${provider.followings![index].user!.name![17]}...", 16, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.justify) :
                                      text(provider.followings![index].user!.name ?? "", 16, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.justify),

                                      provider.followings![index].user!.bio!.length > 20 ?
                                      text("${provider.followings![index].user!.bio![17]}...", 14, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.justify) :
                                      text(provider.followings![index].user!.bio ?? "", 14, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.justify),
                                    ],
                                  )
                                ],
                              ),
                              Consumer<BlogUtilitiesProvider>(
                                  builder: (context, provider1, child){
                                    if(provider1.initialList == 0){
                                      print("yes ${provider1.followingOrNotList}");
                                      provider1.followingOrNotList?.clear();
                                      for(int i = 0; i < provider.followings!.length; i++){
                                        provider1.followingOrNotList?.add(provider.followings![i].isFollowingBack ?? 0);
                                      }
                                    }
                                    return InkWell(
                                      onTap: (){
                                        provider1.changeFollowingList(index, provider.followings![index].isFollowingBack ?? 0);
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
                                            text("Following", 15, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center)
                                            : provider1.followingOrNotList![index] == 1 ? text("Follows You", 15, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center)
                                            : text("Follow", 15, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),

                                            const SizedBox(width: 4.0,),

                                            provider1.followingOrNotList![index] == 0 ?
                                            SvgPicture.asset("assets/images/following_icon.svg", width: 16, height: 16,)
                                            : provider1.followingOrNotList![index] == 1 ?
                                            const SizedBox(width: 0, height: 0,)
                                            : SvgPicture.asset("assets/images/follow_icon.svg", width: 16, height: 16,),

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
