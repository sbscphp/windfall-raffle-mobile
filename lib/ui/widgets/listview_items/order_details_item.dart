import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/core/utilities/date_utilitites.dart';
import 'package:windfall/ui/widgets/cart/row_description_item.dart';
import 'package:windfall/ui/widgets/naira_display.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';
import 'package:windfall/ui/widgets/windfall_tag.dart';

class OrderDeatilsItem extends StatelessWidget {
  final bool isLiveGame;
  const OrderDeatilsItem({super.key, this.isLiveGame = true});

  @override
  Widget build(BuildContext context) {
    return WindfallContainer(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          RowDescriptionItem(
            description: "Game Type:",
            fontSize: 14.sp,
            item: WindfallTag(
              tag: isLiveGame ? TagType.drawGame : TagType.instantGame,
            ),
          ),
          SizedBox(height: 16.h),
          RowDescriptionItem(
            description: "Game Name:",
            fontSize: 14.sp,

            item: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 16.w),
                Flexible(
                  child: Text(
                    "3 Bed Room Flat at Banana Island",
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          RowDescriptionItem(
            description: "No of Tickets Bought:",
            fontSize: 14.sp,

            item: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 16.w),
                Flexible(child: Text("25", textAlign: TextAlign.end)),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          RowDescriptionItem(
            description: "Order Date:",
            fontSize: 14.sp,

            item: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 16.w),
                Flexible(
                  child: Text(
                    DateUtilities.monthDayYear(date: DateTime.now()),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          RowDescriptionItem(
            description: "Unit Price:",
            fontSize: 14.sp,

            item: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 16.w),
                NairaDisplay(
                  amount: 3000,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          RowDescriptionItem(
            description: "Paid Via:",
            fontSize: 14.sp,

            item: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 16.w),
                Flexible(child: Text("Visa *9440", textAlign: TextAlign.end)),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          RowDescriptionItem(
            description: "Status:",
            fontSize: 14.sp,
            item: WindfallTag(tag: TagType.completed),
          ),
          SizedBox(height: 16.h),
          RowDescriptionItem(
            description: "Subtotal:",
            fontSize: 16.sp,
            item: NairaDisplay(
              amount: 300000,
              fontSize: 18.sp,
              color: ColorPath.redOrange,
              addDecimal: false,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
