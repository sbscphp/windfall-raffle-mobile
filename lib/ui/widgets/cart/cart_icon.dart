import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_asset.dart';
import '../clickable.dart';
import '../custom_svg.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Clickable(
        onPressed: (){},
        child: CustomSvg(asset: AppAsset.cart, height: 32.h, width: 32.w,));
  }
}
