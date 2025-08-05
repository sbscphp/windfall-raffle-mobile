import 'package:flutter/material.dart';

import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import 'custom_svg.dart';





///bottom nav items
List<BottomNavigationBarItem> bottomNavItems() {
  return [
    BottomNavigationBarItem(
      activeIcon:CustomSvg(asset: AppAsset.home,
          colorFilter: const ColorFilter.mode(
        ColorPath.redOrange,
        BlendMode.srcIn,
      ),),
      icon: CustomSvg(asset: AppAsset.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      activeIcon:CustomSvg(asset: AppAsset.raffles,
        colorFilter: ColorFilter.mode(
          ColorPath.redOrange,
          BlendMode.srcIn,
        ),),
      icon: CustomSvg(asset: AppAsset.raffles),
      label: 'Raffles',
    ),
    const BottomNavigationBarItem(
      activeIcon:CustomSvg(asset: AppAsset.myGames,
        colorFilter: ColorFilter.mode(
          ColorPath.redOrange,
          BlendMode.srcIn,
        ),),
      icon: CustomSvg(asset: AppAsset.myGames),
      label: 'My Games',
    ),
    const BottomNavigationBarItem(
      activeIcon:CustomSvg(asset: AppAsset.profile,
        colorFilter: ColorFilter.mode(
          ColorPath.redOrange,
          BlendMode.srcIn,
        ),),
      icon: CustomSvg(asset: AppAsset.profile),
      label: 'My Profile',
    ),
  ];
}
