import 'package:flutter/cupertino.dart';

class BottomNavIndexChangeProvider extends ChangeNotifier{
  int myIndex = 0;

  void changeIndex(int index){
    myIndex = index;
    print("myIndex : $myIndex");
    notifyListeners();
  }
}