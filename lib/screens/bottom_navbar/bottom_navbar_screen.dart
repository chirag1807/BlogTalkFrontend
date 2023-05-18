import 'package:blogtalk/providers/BottomNavIndexChangeProvider.dart';
import 'package:blogtalk/screens/bottom_navbar/home_screen.dart';
import 'package:blogtalk/screens/bottom_navbar/notification_screen.dart';
import 'package:blogtalk/screens/bottom_navbar/your_posts_screen.dart';
import 'package:blogtalk/screens/bottom_navbar/saved_posts_screen.dart';
import 'package:blogtalk/utils/constants.dart';
import 'package:blogtalk/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int myIndex= 0;
    final screens = [
      const HomeScreen(),
      const YourPostsScreen(),
      const NotificationScreen(),
      const SavedPostsScreen()
    ];
    double w = getWidth(context);
    double h = getHeight(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavIndexChangeProvider())
      ],
      child: Scaffold(
        backgroundColor: themeColorBlue,
        body: Consumer<BottomNavIndexChangeProvider>(
          builder: (context, provider, child){
          return SafeArea(
            child: Container(
              width: w,
              height: h,
              padding: const EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(gradient: appBodyGradient()),
              child: screens[provider.myIndex],
            ),
          );
          }
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: h * 0.08,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10),
              ],
              color: themeColorBlue
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                color: const Color(0xA6FFFFFF),
                width: w,
                child: Consumer<BottomNavIndexChangeProvider>(
                  builder: (context, provider, child){
                    myIndex = provider.myIndex;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      myIndex == 0 ?
                      selectedContainer(w, 'assets/images/home_icon.svg', 'Home') :
                      InkWell(
                          onTap: (){
                            provider.changeIndex(0);
                          },
                          child: unselectedContainer(w, 'assets/images/home_icon.svg')),

                      myIndex == 1 ?
                      selectedContainer(w, 'assets/images/your_posts_icon.svg', 'Posts') :
                      InkWell(
                          onTap: (){
                            provider.changeIndex(1);
                          },
                          child: unselectedContainer(w, 'assets/images/your_posts_icon.svg')),

                      myIndex == 2 ?
                      selectedContainer(w, 'assets/images/notification_icon.svg', 'Notification') :
                      InkWell(
                          onTap: (){
                            provider.changeIndex(2);
                          },
                          child: unselectedContainer(w, 'assets/images/notification_icon.svg')),

                      myIndex == 3 ?
                      selectedContainer(w, 'assets/images/saved_posts_icon.svg', 'Saved') :
                      InkWell(
                          onTap: (){
                            provider.changeIndex(3);
                          },
                          child: unselectedContainer(w, 'assets/images/saved_posts_icon.svg')),
                    ],
                  );
                  }
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}

Container unselectedContainer(double w, String iconPath){
  return Container(
      width: w * 0.15,
      child: SvgPicture.asset(
          iconPath,
          width: 35,
          height: 35,
      )
  );
}
Container selectedContainer(double w, String iconPath, String label){
  return Container(
    width: w * 0.30,
    margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
    padding: const EdgeInsets.all(5.0),
    decoration: BoxDecoration(
        gradient: appBodyGradient(),
        borderRadius: BorderRadius.circular(12.0),
      boxShadow: const [
        BoxShadow(
          color: Color(0x40000000),
          offset: Offset(
            3.0,
            3.0,
          ),
          blurRadius: 4.0,
        )
      ]
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 35,
          height: 35,
        ),
        Flexible(
          child: Text(label,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: themeColorWhite
          ),),
        )
      ],
    ),
  );
}
