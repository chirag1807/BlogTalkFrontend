import 'dart:async';
import 'dart:collection';

import 'package:blogtalk/models/ListAndMap.dart';
import 'package:blogtalk/providers/UserRegLoginProvider.dart';
import 'package:blogtalk/repositories/UserRegLogin.dart';
import 'package:blogtalk/screens/bottom_navbar/bottom_navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../utils/widgets.dart';

class SelectTopicsScreen extends StatefulWidget {
  final int indicator;
  const SelectTopicsScreen({Key? key, required this.indicator}) : super(key: key);

  @override
  State<SelectTopicsScreen> createState() => _SelectTopicsScreenState();
}

class _SelectTopicsScreenState extends State<SelectTopicsScreen> {

  List<String> favTopics = [];


  @override
  void dispose(){
    super.dispose();
    favTopics.clear();
  }

  @override
  Widget build(BuildContext context) {
    double w = getWidth(context);
    double h = getHeight(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserRegLoginProvider()),
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
                gradient: appBodyGradient()
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: w,
                    decoration: const BoxDecoration(
                        color: themeColorHint,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(100.0))
                    ),
                    padding: const EdgeInsets.all(25.0),
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Choose your Preferred Topics", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                        const SizedBox(height: 10.0,),
                        text("Select two or more", 14, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center),
                      ],
                    ),
                  ),
                ),
                  Expanded(
                    flex: 4,
                    child: Container(
                        width: w,
                        padding: const EdgeInsets.all(30.0),
                        child: FutureBuilder<ListAndMap?>(
                          future: UserRegLogin().getAllTopicNameId(),
                          builder: (context, snapshot){
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return const Center(child: CircularProgressIndicator(color: themeColorWhite,),);
                            }
                            else{
                              if(snapshot.hasData){
                                var snapshotData = snapshot.data!;

                                for(int j = 0; j<snapshotData.favTopics.length; j++){
                                  if(snapshotData.allTopicsNameId.keys.contains(snapshotData.favTopics[j])){
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      Provider.of<UserRegLoginProvider>(context, listen: false).addRemoveToUserFavTopic(
                                          snapshotData.allTopicsNameId[snapshotData.favTopics[j]] ?? "", 0);
                                    });
                                  }
                                }

                                return Consumer<UserRegLoginProvider>(
                                  builder: (context, provider, child){

                                    favTopics = Provider.of<UserRegLoginProvider>(context).userFavTopics;
                                    print("yesyesyes ${favTopics.toString()}");

                                  return GridView.builder(
                                    itemBuilder: (context, index){
                                      return InkWell(
                                        onTap: (){
                                          if(favTopics.contains(snapshot.data?.allTopicsNameId.values.elementAt(index))){
                                            Provider.of<UserRegLoginProvider>(context, listen: false).addRemoveToUserFavTopic(
                                                snapshot.data?.allTopicsNameId.values.elementAt(index) ?? "", 1);
                                          }
                                          else{
                                            Provider.of<UserRegLoginProvider>(context, listen: false).addRemoveToUserFavTopic(
                                                snapshot.data?.allTopicsNameId.values.elementAt(index) ?? "", 0);
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            gradient: provider.userFavTopics.contains(
                                                snapshot.data?.allTopicsNameId.values.elementAt(index)) ? appBodyGradient() :
                                                const LinearGradient(colors: [themeColorWhite, themeColorWhite]),
                                              borderRadius: BorderRadius.circular(5.0),
                                            border: Border.all(color: themeColorWhite)
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            snapshot.data?.allTopicsNameId.values.elementAt(index) ?? "",
                                            textAlign: TextAlign.center, style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: provider.userFavTopics.contains(
                                                snapshot.data?.allTopicsNameId.values.elementAt(index)) ? themeColorWhite : themeColorBlack
                                          ),),
                                        ),
                                      );
                                    },
                                    itemCount: snapshot.data?.allTopicsNameId.length ?? 0,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10.0,
                                      crossAxisSpacing: 12.0,
                                      childAspectRatio: (1 / .4)
                                  )
                                  );
                                  }
                                );
                              }
                              else {
                                return Center(child: text(errorMsg, 14, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center),);
                              }
                            }
                          },
                        ),
                      ),
                  ),
                Expanded(
                  flex: 1,
                  child: Container(
                      width: w,
                      decoration: const BoxDecoration(
                          color: themeColorHint,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(100.0))
                      ),
                      alignment: Alignment.center,
                      child: Consumer<UserRegLoginProvider>(
                        builder: (context, provider, child){
                          if(provider.setUpdateFavTopicsDone == 1){
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(displaySnackBar(
                                  "Your Preferred Topics has been Set Successfully", themeColorSnackBarGreen));
                              Timer(const Duration(seconds: 1), () {
                                Get.offAll(() => const BottomNavBarScreen());
                              });
                            });
                          }
                          else if(provider.setUpdateFavTopicsDone == 0){
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(displaySnackBar(errorMsg, themeColorSnackBarRed));
                            });
                          }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Button(
                              width: 125,
                              onTap: (){
                                if(favTopics.length < 2){
                                  // WidgetsBinding.instance.addPersistentFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(displaySnackBar(
                                        "Please select at least two preferred topics", themeColorSnackBarRed));
                                  // });
                                }
                                else{
                                  print(favTopics);
                                  provider.setUpdateFavTopics(favTopics, widget.indicator);
                                }

                              },
                              child:
                              provider.circularBarShow == 1 ? const CircularProgressIndicator(color: themeColorWhite,) :
                              text("Submit", 20, FontWeight.w500, themeColorWhite, TextDecoration.none, TextAlign.center),
                            ),
                          ],
                        );
                        }
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
