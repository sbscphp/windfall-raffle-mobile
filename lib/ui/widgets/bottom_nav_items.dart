import 'package:flutter/material.dart';

import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import 'custom_svg.dart';





///bottom nav items
List<BottomNavigationBarItem> bottomNavItems(BuildContext context) {
  return [
    BottomNavigationBarItem(
      activeIcon:CustomSvg(asset: AppAsset.onboarding1,
          colorFilter: const ColorFilter.mode(
        ColorPath.redOrange,
        BlendMode.srcIn,
      ),),
      icon: CustomSvg(asset: AppAsset.onboarding1),
      label: 'Games',
    ),
    const BottomNavigationBarItem(
      activeIcon:CustomSvg(asset: AppAsset.onboarding1,
        colorFilter: ColorFilter.mode(
          ColorPath.redOrange,
          BlendMode.srcIn,
        ),),
      icon: CustomSvg(asset: AppAsset.onboarding1),
      label: 'My Games',
    ),
    const BottomNavigationBarItem(
      activeIcon:CustomSvg(asset: AppAsset.onboarding1,
        colorFilter: ColorFilter.mode(
          ColorPath.redOrange,
          BlendMode.srcIn,
        ),),
      icon: CustomSvg(asset: AppAsset.onboarding1),
      label: 'Reward',
    ),
    const BottomNavigationBarItem(
      activeIcon:CustomSvg(asset: AppAsset.onboarding1,
        colorFilter: ColorFilter.mode(
          ColorPath.redOrange,
          BlendMode.srcIn,
        ),),
      icon: CustomSvg(asset: AppAsset.onboarding1),
      label: 'Settings',
    ),
  ];
}
