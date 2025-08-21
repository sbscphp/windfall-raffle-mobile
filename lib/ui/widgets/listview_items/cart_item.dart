import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
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

class CartItem extends StatefulWidget {
  final bool isShowCounter;
  final bool isInstantGame;
  const CartItem({
    super.key,
    this.isShowCounter = true,
    this.isInstantGame = false,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late double quantity;

  @override
  void initState() {
    quantity = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        'https://mir-s3-cdn-cf.behance.net/user/276/888fd91082619909.61d2827bbd7a2.jpg',
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
                                "Secure a Luxury Studio Apartment in Lagos State, Nigeria.",
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
                                "Enter now to grab the opportunity of a bra...",
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
                            showFlushBar(
                              context: context,
                              message: "Product removed from Cart Successfuly",
                              success: false,
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
                    if (widget.isInstantGame)
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
                                  amount: 4000,
                                  fontSize: 16.sp,
                                  addDecimal: false,
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
                                  value: quantity.toInt(),
                                  buttonSpacing: 2.w,
                                  swapButtons: true,
                                  showBottomBorder: true,
                                  upperLimit: 33,
                                  onChanged: (value) {
                                    setState(() {
                                      quantity = value.toDouble() ?? 1;
                                    });
                                  },
                                )
                              : Text(
                                  "20",
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
              amount: quantity * 4000,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              addDecimal: false,
            ),
          ),
        ],
      ),
    );
  }
}
