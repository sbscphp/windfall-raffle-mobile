import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../constants/app_asset.dart';


class LandingViewModel extends ChangeNotifier{

  //scroll controller
  final SwiperController _swiperController = SwiperController();
  SwiperController get swiperController => _swiperController;

  //index for swiper
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;


  final List<String> _images = [
    AppAsset.onboarding1,
    AppAsset.onboarding2,
    AppAsset.onboarding3,
  ];
  List<String> get images => _images;

  final List<String> _titles = [
    "Your Lucky Day Awaits",
    "Small Bet, Big Dreams",
    "Instant Win Alerts",
  ];
  List<String> get titles => _titles;

  final List<String> _subtitles = [
    "Every ticket is a doorway to possibility. With just ₦5K, you're one draw away from driving home in a brand-new car.",
    "₦5K opens doors to prizes worth millions. Why dream small when affordable tickets can deliver extraordinary rewards?.",
    "Victory comes with a notification. Our instant alert system ensures you never miss your winning moment.",
  ];
  List<String> get subtitles => _subtitles;




  void moveToNext(){
    _swiperController.move(_currentIndex + 1);
    notifyListeners();
  }

  void moveToEnd(){
    _swiperController.move(2);
    notifyListeners();
  }

  void moveToPrevious(){
    _swiperController.move(_currentIndex - 1);
    notifyListeners();
  }

  void updateIndex(index){
    _currentIndex = index;
    notifyListeners();
  }


  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }



}

final landingViewModel = ChangeNotifierProvider.autoDispose<LandingViewModel>((ref){
  return LandingViewModel();
});