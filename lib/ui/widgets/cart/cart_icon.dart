import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/cart/cart.dart';

import '../../../core/constants/app_asset.dart';
import '../clickable.dart';
import '../custom_svg.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Clickable(
        onPressed: (){
          pushNavigation(context: context,widget: Cart(),routeName: NamedRoutes.cart);
        },
        child: CustomSvg(asset: AppAsset.cart, height: 32.h, width: 32.w,));
  }
}
