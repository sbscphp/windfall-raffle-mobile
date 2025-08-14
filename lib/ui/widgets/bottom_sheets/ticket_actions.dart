import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_divider.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/listview_items/ticket_item.dart';

import '../../../core/constants/color_path.dart';
import '../custom_button.dart';
import '../screen_title.dart';

class TicketActions extends StatelessWidget {
  const TicketActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimension.paddingTop, horizontal: AppDimension.paddingRight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ScreenTitle(
                    title: 'Raffle Tickets',
                    titleSize: 16,
                    subTitleSize: 14,
                    titleFontWeight: FontWeight.w600,
                    titleColor: Theme.of(context).colorScheme.textPrimary,
                    subTitle: 'Details of a ticket entries for this game.'
                ),
              ),
              SizedBox(width: 10.w,),
              Clickable(
                onPressed: (){
                  popNavigation(context: context);
                },
                  child: CustomSvg(asset: AppAsset.close))
              

            ],
          ),
          CustomDivider(
            equalVerticalSpace: false,
            verticalSpace: 5.h,
            bottomMargin: 24.h,
            color: ColorPath.athensGrey4,
          ),
          TicketItem(),
          SizedBox(height: 32.h,),
          CustomButton(
              useDottedBorder: true,
              buttonText:'Download Ticket',
              showButtonIcon: true,
              buttonIcon: AppAsset.downloadTicket,
              onPressed: (){

              }
          ),
          SizedBox(height: 24.h,),
          CustomButton(
            bgColor: Theme.of(context).colorScheme.blackText,
              useDottedBorder: true,
              buttonText:'Copy Ticket Number',
              showButtonIcon: true,
              buttonIcon: AppAsset.copy,
              onPressed: (){

              }
          ),


        ],
      ),
    );
  }
}
