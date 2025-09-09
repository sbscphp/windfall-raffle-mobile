import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/data/view_models/cart_vm.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/cart/cart.dart';

import '../../../core/constants/app_asset.dart';
import '../clickable.dart';
import '../custom_svg.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(cartViewModel);

    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Clickable(
            onPressed: () {
              pushNavigation(
                context: context,
                widget: Cart(),
                routeName: NamedRoutes.cart,
              );
            },
            child: CustomSvg(
              asset: AppAsset.cart,
              height: 32.h,
              width: 32.w,
            ),
          ),
          Positioned(
            right: -12,
            top: -6,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animation,
                    curve: Curves.elasticOut,
                  ),
                  child: child,
                );
              },
              child: vm.showCartBadge
                  ? Container(
                key: ValueKey(vm.cartCount),
                height: 23,
                width: 23,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.blackText,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      "${vm.cartCount}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.whiteText,
                      ),
                    ),
                  ),
                ),
              )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );




    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Clickable(
              onPressed: (){
                pushNavigation(context: context,widget: Cart(),routeName: NamedRoutes.cart);
              },
              child: CustomSvg(asset: AppAsset.cart, height: 32.h, width: 32.w,)),
         if(vm.showCartBadge)Positioned(
            right: -12,
            top: -6,
            child: Container(
              height: 23,
              width: 23,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle
              ),
              child: Center(
                child: FittedBox(
                  child: Text(
                    "${vm.cartCount}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
