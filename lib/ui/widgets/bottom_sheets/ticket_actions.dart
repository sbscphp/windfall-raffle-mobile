import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/models/game.dart';
import 'package:windfall/core/data/models/ticket.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_divider.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/listview_items/ticket_item.dart';

import '../../../core/constants/color_path.dart';
import '../../../core/utilities/receipt_utils.dart';
import '../custom_button.dart';
import '../screen_title.dart';
import '../show_flush_bar.dart';

class TicketActions extends StatefulWidget {
  final Ticket ticket;
  final bool isInstantGame;
  const TicketActions({super.key, required this.ticket, required this.isInstantGame});

  @override
  State<TicketActions> createState() => _TicketActionsState();
}

class _TicketActionsState extends State<TicketActions> {
  late GlobalKey _globalKey;

  @override
  void initState() {
    _globalKey = GlobalKey();
    super.initState();
  }


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
          RepaintBoundary(
              key: _globalKey,
              child: TicketItem(ticket: widget.ticket, isInstantGame: widget.isInstantGame,)),
          SizedBox(height: 32.h,),
          CustomButton(
              useDottedBorder: true,
              buttonText:'Download Ticket',
              showButtonIcon: true,
              buttonIcon: AppAsset.downloadTicket,
              onPressed: (){
                ReceiptUtils.saveImageToGallery(key: _globalKey, context: context);
              }
          ),
          SizedBox(height: 24.h,),
          CustomButton(
            bgColor: Theme.of(context).colorScheme.blackText,
              useDottedBorder: true,
              buttonText:'Copy Ticket Number',
              showButtonIcon: true,
              buttonIcon: AppAsset.copy,
              onPressed: ()async{
                await Clipboard.setData(ClipboardData(text: widget.ticket.ticketNumber ?? ''));
                showFlushBar(
                  context: context,
                  message: "Ticket number copied to ClipBoard",
                );
              }
          ),


        ],
      ),
    );
  }
}
