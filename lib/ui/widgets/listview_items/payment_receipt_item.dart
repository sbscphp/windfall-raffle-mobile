import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/data/models/order_detail.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/my_games/game_tickets.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

import '../../../core/data/enum/tag_type.dart';
import '../../../core/utilities/utilities.dart';
import '../windfall_tag.dart';

class PaymentReceiptItem extends StatelessWidget {
  final OrderDetail orderDetail;
  const PaymentReceiptItem({super.key, required this.orderDetail});

  @override
  Widget build(BuildContext context) {
    final name = orderDetail.game?.name ?? 'N/A';
    final description = orderDetail.game?.description ?? 'N/A';
    final ticketCount = orderDetail.quantity ?? 1;
    final isInstantGame = orderDetail.game?.instantGame?.toLowerCase() == 'true';
    final unitPrice = double.tryParse(orderDetail.unitAmount?.toString() ?? '0') ?? 0;
    final totalPrice = double.tryParse(orderDetail.paidAmount?.toString() ?? '0') ?? 0;
    final discountAmount = double.tryParse(orderDetail.discountAmount?.toString() ?? '0') ?? 0;
    return Clickable(
      onPressed: () {
        pushNavigation(
          context: context,
          widget: GameTickets(
            id: orderDetail.game?.uuid,
            appbarTitle: 'Ticket Details',
          ),
          routeName: NamedRoutes.gameTickets,
        );
      },
      child: WindfallContainer(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAssetViewer(
              asset: AppAsset.walletImg,
              height: 64.h,
              width: 64.w,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                             description,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontSize: 10.sp,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      if(isInstantGame)Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: WindfallTag(tag: TagType.instantGame),
                      )
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PaymentItemLabel(
                              asset: AppAsset.ticket2,
                              label: "${ticketCount > 1 ? 'Tickets':'Ticket'}",
                              data: "$ticketCount",
                            ),
                            SizedBox(height: 8.h,),
                            PaymentItemLabel(
                              asset: AppAsset.discount,
                              label: "Discount",
                              data: "₦${Utilities.formatAmount(
                                  addDecimal: true,
                                  amount: discountAmount
                              )}",
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PaymentItemLabel(
                              asset: AppAsset.unitPrice,
                              label: "Unit Price",
                              data: "₦${Utilities.formatAmount(
                                  addDecimal: true,
                                  amount: unitPrice
                              )}",
                            ),
                            SizedBox(height: 8.h,),
                            PaymentItemLabel(
                              asset: AppAsset.subTotal,
                              label: "Sub-total",
                              data: "₦${Utilities.formatAmount(
                                  addDecimal: true,
                                  amount: totalPrice
                              )}",
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentItemLabel extends StatelessWidget {
  final String asset;
  final String? label;
  final String? data;
  const PaymentItemLabel({
    super.key,
    required this.asset,
    this.label,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomAssetViewer(asset: asset, height: 12.w, width: 12.w),
        SizedBox(width: 6.w),
        Flexible(
          child: FittedBox(
            child: Text.rich(
              TextSpan(
                text: "$label: ",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.textSecondary,
                ),
                children: [
                  TextSpan(
                    text: data,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
