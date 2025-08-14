import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/utilities/date_utilitites.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/my_games/game_tickets.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

class PaymentReceiptItem extends StatelessWidget {
  const PaymentReceiptItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: () {
        pushNavigation(
          context: context,
          widget: GameTickets(),
          routeName: NamedRoutes.gameTickets,
        );
      },
      child: WindfallContainer(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
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
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "1 Bed Room Flat at Banana Island, Lagos State",
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
                              "Win 1 bed room flat at the high prestige location",
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
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PaymentItemLabel(
                        asset: AppAsset.ticket2,
                        label: "Tickets",
                        data: "23",
                      ),
                      SizedBox(width: 4.w),
                      Container(
                        height: 16.h,
                        width: 1.w,
                        color: ColorPath.mischkaGrey,
                      ),
                      SizedBox(width: 4.w),
                      PaymentItemLabel(
                        asset: AppAsset.calendar2,
                        label: "Draw Date",
                        data: DateUtilities.dM(DateTime.now()),
                      ),
                      SizedBox(width: 8.h),
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
        Text.rich(
          TextSpan(
            text: "$label: ",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 10.sp,
              color: Theme.of(context).colorScheme.textSecondary,
            ),
            children: [
              TextSpan(
                text: data,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
