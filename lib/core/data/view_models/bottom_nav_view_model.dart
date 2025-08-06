import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windfall/ui/pages/games/games.dart';
import 'package:windfall/ui/pages/home/home.dart';
import 'package:windfall/ui/pages/my_games/my_games.dart';
import 'package:windfall/ui/pages/profile/profile.dart';




class BottomNavViewModel extends ChangeNotifier{

  //current index of the bottom nav-bar
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void setCurrentIndex(int value, {bool refreshUi = true}){
    _currentIndex = value;
    if(refreshUi){
      notifyListeners();
    }
  }


  //children of the bottom Nav
  final List<Widget>  _children = [
    Home(),
    Games(),
    MyGames(),
    Profile(),
  ];
  List<Widget> get children => _children;


  //updates the current index of the bottom nav
  void updateIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }

}

final bottomNavViewModel = ChangeNotifierProvider.autoDispose<BottomNavViewModel>((ref){
  return BottomNavViewModel();
});