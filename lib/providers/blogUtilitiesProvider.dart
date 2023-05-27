import 'package:flutter/widgets.dart';

class BlogUtilitiesProvider extends ChangeNotifier{
  int liked = -1;
  int likeCount = 0;
  int initialLike = 0;
  int followingOrNot = -1;
  int initialFollowingOrNot = 0;
  int savedOrNot = -1;
  int initialSavedOrNot = 0;
  List<int>? followingOrNotList = [];
  int initialList = 0;

  void changeLikeIcon(int like, int likedCount) {
    initialLike = 1;
    liked = like;
    likeCount += likedCount;
    notifyListeners();
  }

  void changeFollowing(int followingYesOrNo){
    initialFollowingOrNot = 1;
    followingOrNot = followingYesOrNo;
    notifyListeners();
  }

  void changeSaveToPost(int savedYesOrNo){
    initialSavedOrNot = 1;
    savedOrNot = savedYesOrNo;
    notifyListeners();
  }

  void changeFollowingInList(int index){
    initialList = 1;
    followingOrNotList![index] = followingOrNotList![index] == 0 ? 1 : 0;
    notifyListeners();
  }

  void changeFollowingList(int index, int providerValue){
    initialList = 1;
    followingOrNotList![index] = (followingOrNotList![index] ==  0 || followingOrNotList![index] ==  1) ? 2 : providerValue;
    notifyListeners();
  }
}