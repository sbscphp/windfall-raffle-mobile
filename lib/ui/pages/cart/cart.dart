import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/checkout/checkout.dart';
import 'package:windfall/ui/widgets/app_loader.dart';
import 'package:windfall/ui/widgets/body_header.dart';
import 'package:windfall/ui/widgets/busy_overlay.dart';
import 'package:windfall/ui/widgets/cart/row_description_item.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/empty_state.dart';
import 'package:windfall/ui/widgets/error_state.dart';
import 'package:windfall/ui/widgets/listview_items/cart_item.dart';
import 'package:windfall/ui/widgets/screen_title.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';
import '../../../core/data/enum/checkout_type.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/bottom_nav_view_model.dart';
import '../../../core/data/view_models/cart_vm.dart';
import '../../../core/data/view_models/checkout_vm.dart';
import '../../../core/utilities/utilities.dart';

class Cart extends ConsumerStatefulWidget {
  const Cart({super.key});

  @override
  ConsumerState<Cart> createState() => _CartState();
}

class _CartState extends ConsumerState<Cart> {

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(cartViewModel).fetchCart();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(cartViewModel);
    return BusyOverlay(
      show: vm.secondState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          showLeadingIcon: true,
          title: 'Cart',
        ),
        body: Builder(
          builder: (context) {
            final vm = ref.watch(cartViewModel);

            if(vm.state == ViewState.busy){
              return Center(
                child: AppLoader(),
              );
            }

            if(vm.state == ViewState.retrieved){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyHeader(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ScreenTitle(
                            title: 'My Game Cart',
                            titleExtension: ' (${vm.cartCount})',
                            titleSize: 16,
                            subTitleSize: 14,
                            titleFontWeight: FontWeight.w600,
                            titleColor: Theme.of(context).colorScheme.textPrimary,
                            subTitle:
                            'See the list of raffle tickets you want to buy. Checkout now before the draw.',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: vm.cartItems.isNotEmpty
                        ? ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimension.paddingLeft,
                        vertical: 16.h,
                      ),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final cartItem = vm.cartItems[index];
                        return CartItem(
                          item: cartItem,
                          index: index,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 16.h);
                      },
                      itemCount: vm.cartItems.length,
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
                          onPressed: () {
                            final container =
                            ProviderScope.containerOf(context);

                            final bottomNavVm =
                            container.read(bottomNavViewModel);

                            bottomNavVm.updateIndex(1);

                            popNavigation(context: context);
                          },
                        ),
                      ],
                    ),
                  ),
                  //show summary only when there are items in the cart
                  vm.showCartBadge
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
                              "${Utilities.formatAmount(
                                amount: vm.totalNumberOfTickets,
                                addDecimal: false
                              )} ${vm.totalNumberOfTickets > 1 ? 'Tickets':'Ticket'}",
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
                          // SizedBox(height: 16.h),
                          // RowDescriptionItem(
                          //   description: "Total Prices of Ticket:",
                          //   item: NairaDisplay(
                          //     amount: 480000,
                          //     fontSize: 18.sp,
                          //     fontWeight: FontWeight.w700,
                          //     addDecimal: false,
                          //   ),
                          // ),
                          SizedBox(height: 16.h),
                          CustomButton(
                            onPressed: () {
                              final checkoutVm = ref.read(checkoutViewModel);
                              //set checkout type
                              checkoutVm.checkoutType = CheckoutType.cart;
                              //generate checkout item
                              checkoutVm.initCheckoutItems(input: vm.cartItems);

                              pushNavigation(
                                context: context,
                                widget: Checkout(),
                                routeName: NamedRoutes.checkout,
                              );
                            },
                            useDottedBorder: true,
                            buttonText: "Checkout ~ ₦${Utilities.formatAmount(
                                amount: vm.totalCheckoutAmount,
                                addDecimal: true
                            )}",
                          ),
                        ],
                      ),
                    ),
                  )
                      : SizedBox(),
                  SizedBox(height: 16.h),
                ],
              );
            }

            if(vm.state == ViewState.error){
              return Center(
                child: ErrorState(
                  message: vm.message,
                    onPressed: ()=>vm.fetchCart()
                ),
              );
            }

            return const SizedBox();

          }
        ),
      ),
    );
  }
}
