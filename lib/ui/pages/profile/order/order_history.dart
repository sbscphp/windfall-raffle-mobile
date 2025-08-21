import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/custom_text_field.dart';
import 'package:windfall/ui/widgets/listview_items/order_history_item.dart';
import 'package:windfall/ui/widgets/screen_title.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Order History'),
      body: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          left: AppDimension.paddingLeft,
          right: AppDimension.paddingRight,
        ),
        child: Column(
          children: [
            ScreenTitle(
              title: "Order History",
              subTitle: "Track and manage your order history.",
            ),
            CustomTextField(
              isCompulsory: false,
              hintText: "Search",
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 12, right: 12.w),
                child: CustomSvg(asset: AppAsset.search),
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(top: 8.h),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _buildSingleDateItems(index);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 8.h);
                },
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleDateItems(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          index == 0
              ? "Today"
              : index > 1
              ? "3 days ago"
              : "Yesterday",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.textTertiary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return OrderHistoryItem();
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.h);
          },
          itemCount: 3,
        ),
      ],
    );
  }
}
