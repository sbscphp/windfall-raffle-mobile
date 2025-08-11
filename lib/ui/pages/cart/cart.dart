import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/cart/checkout.dart';
import 'package:windfall/ui/widgets/body_header.dart';
import 'package:windfall/ui/widgets/cart/row_description_item.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/empty_state.dart';
import 'package:windfall/ui/widgets/listview_items/cart_item.dart';
import 'package:windfall/ui/widgets/naira_display.dart';
import 'package:windfall/ui/widgets/screen_title.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        showLeadingIcon: true,
        title: 'Cart',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ScreenTitle(
                    title: 'My Game Cart',
                    titleExtension: ' (0)',
                    titleSize: 16,
                    subTitleSize: 14,
                    titleFontWeight: FontWeight.w600,
                    titleColor: Theme.of(context).colorScheme.textPrimary,
                    subTitle:
                        'See the list of Raffle Ticket you want buy. Checkout now before draw.',
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: 1 + 1 == 2
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimension.paddingLeft,
                      vertical: 16.h,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CartItem();
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 16.h);
                    },
                    itemCount: 5,
                  )
                :
                  // EmptyState
                  Column(
                    children: [
                      SizedBox(height: 40.h),
                      EmptyState(
                        asset: AppAsset.emptyCart,
                        useBgCard: false,
                        assetHeight: 128.h,
                        assetWidth: 128.w,
                        title: "No Ticket in Cart",
                        ctaText: "Explore All Games",
                        subtitle:
                            "You currently have no ticket (s) in your Cart. Explore raffle games to add ticket (s) to your Cart.",
                        onPressed: () {},
                      ),
                    ],
                  ),
          ),
          //show summary only when there are items in the cart
          1 + 1 == 2
              ? Padding(
                  padding: EdgeInsets.all(16.w),
                  child: WindfallContainer(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "My Cart Summary",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                color: Theme.of(context).colorScheme.brandColor,
                              ),
                        ),
                        SizedBox(height: 16.h),
                        RowDescriptionItem(
                          description: "Total Number of Ticket:",
                          item: Text(
                            "0 Ticket",
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.sp,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.textPrimary,
                                ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        RowDescriptionItem(
                          description: "Total Prices of Ticket:",
                          item: NairaDisplay(
                            amount: 480000,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            addDecimal: false,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        CustomButton(
                          onPressed: () {
                            pushNavigation(context: context, widget: Checkout(),routeName: NamedRoutes.checkout);
                          },
                          useDottedBorder: true,
                          buttonText: "Checkout ~ ₦480,000",
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
