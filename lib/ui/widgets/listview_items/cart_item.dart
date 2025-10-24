import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/core/data/enum/checkout_type.dart';
import 'package:windfall/core/data/view_models/cart_vm.dart';
import 'package:windfall/core/data/view_models/checkout_vm.dart';
import 'package:windfall/ui/widgets/cart/column_description_item.dart';
import 'package:windfall/ui/widgets/cart/row_description_item.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/media_placeholder.dart';
import 'package:windfall/ui/widgets/naira_display.dart';
import 'package:windfall/ui/widgets/quantity_counter.dart';
import 'package:windfall/ui/widgets/show_flush_bar.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';
import 'package:windfall/ui/widgets/windfall_tag.dart';
import '../../../core/data/enum/tag_type.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/models/cart_product.dart';
import '../../../core/utilities/debouncer.dart';
import '../../../core/utilities/navigator.dart';
import '../../../core/utilities/utilities.dart';
import '../bottom_sheets/base_bottom_sheet.dart';
import '../bottom_sheets/custom_bottom_sheet.dart';


class CartItem extends StatefulWidget {
  final bool isShowCounter;
  final CartProduct item;
  final int? index;
  const CartItem({
    super.key,
    this.isShowCounter = true,
    required this.item,
    this.index
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

  late Debouncer debouncer;

  @override
  void initState() {
    debouncer = Debouncer(milliseconds: 800);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final container =
    ProviderScope.containerOf(context);
    final vm =
    container.read(cartViewModel);
    final checkoutVm = container.read(checkoutViewModel);
    final id = widget.item.gameId;
    final isInstantGame = widget.item.instantGame?.toLowerCase() == 'true';
    final image = widget.item.cardImage ?? '';
    final name = widget.item.gameName ?? 'N/A';
    final desc = widget.item.description ?? 'N/A';
    final discountedUnitPrice = double.tryParse(widget.item.discountedUnitPrice?.toString() ?? '0') ?? 0;
    final subtotal = double.tryParse(widget.item.totalPrice?.toString() ?? '0') ?? 0;
    final minQuantity = widget.item.minimumTicketNumberPurchase ?? 1;
    final maxAvailable = widget.item.maximumTicketNumberPurchase ?? 1;
    final ticketsLeft = widget.item.ticketsLeft ?? 1;
    final maxQuantity = ticketsLeft < maxAvailable ? ticketsLeft : maxAvailable;
    final quantity = widget.item.quantity ?? 1;
    return WindfallContainer(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: ColorPath.redOrange,
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4.r)),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    imageUrl:
                        image,
                    placeholder: (context, url) => const MediaPlaceholder(),
                    errorWidget: (context, url, error) =>
                        const MediaPlaceholder(),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.textPrimary,
                                    ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                desc,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.textSecondary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Clickable(
                          onPressed: () {

                            baseBottomSheet(
                              context: context,
                              content: CustomBottomSheet(
                                title: "Delete Ticket?",
                                subTitle:
                                "Are you sure you want to delete this ticket? Kindly note that this action cannot be reversed",
                                firstbuttonText: "Yes, Delete",
                                secondButtonText: "No, Close",
                                firstButtonOnPressed: ()async{

                                  popNavigation(context: context);

                                  if (widget.isShowCounter || checkoutVm.checkoutType == CheckoutType.cart) {
                                    await vm.deleteItem(gameId: id);
                                    showFlushBar(
                                      context: context,
                                      message: vm.message,
                                      success: vm.secondState == ViewState.retrieved,
                                    );
                                  }

                                  if (!widget.isShowCounter) {
                                    checkoutVm.removeItem(index: widget.index ?? 0);
                                  }



                                },
                                secondButtonOnPressed: (){
                                  popNavigation(context: context);
                                },
                                asset: Image.asset(
                                  AppAsset.warning,
                                  height: 100.h,
                                  width: 100.w,
                                ),
                              ),
                            );

                          },
                          child: CustomSvg(
                            asset: AppAsset.delete,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                      ],
                    ),
                    if (isInstantGame)
                      Column(
                        children: [
                          SizedBox(height: 8.w),
                          WindfallTag(tag: TagType.instantGame),
                        ],
                      ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ColumnDescriptionItem(
                            description: "Price Per Ticket",
                            item: Column(
                              children: [
                                if (widget.isShowCounter)
                                  SizedBox(height: 10.h),
                                NairaDisplay(
                                  amount: discountedUnitPrice,
                                  fontSize: 16.sp,
                                  addDecimal: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ColumnDescriptionItem(
                          description: "Quantity",
                          crossAxisAlignment: widget.isShowCounter
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          item: widget.isShowCounter
                              ? QuantityCounter(
                                  value: quantity,
                                  buttonSpacing: 2.w,
                                  swapButtons: true,
                                  showBottomBorder: true,
                                  upperLimit: maxQuantity,
                                  lowerLimit: minQuantity,
                                  onChanged: (value) async{
                                    debouncer.performAction(action: () async {
                                      await vm.addToCart(
                                          index: widget.index,
                                          gameId: id,
                                          quantity: value.toInt(),
                                          isUpdatingCart: true
                                      );
                                      showFlushBar(
                                          context: context,
                                          message: vm.message,
                                          success: vm.secondState == ViewState.retrieved
                                      );
                                    });

                                  },
                                )
                              : Text(
                                  "${Utilities.formatAmount(
                                    addDecimal: false,
                                    amount: double.tryParse(quantity.toString()) ?? 1
                                  )}",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.textPrimary,
                                      ),
                                ),
                        ),
                        if (!widget.isShowCounter) SizedBox(width: 30.w),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            height: 1.h,
            color: Theme.of(context).colorScheme.appbarDivider,
          ),
          SizedBox(height: 16.h),
          RowDescriptionItem(
            description: widget.isShowCounter ? "Subtotal:" : "Total Price:",
            item: NairaDisplay(
              //amount: quantity * 4000,
              amount: subtotal,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              addDecimal: true,
            ),
          ),
        ],
      ),
    );
  }
}
