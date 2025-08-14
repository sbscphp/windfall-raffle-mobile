import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/ui/widgets/listview_items/ticket_item.dart';
import '../../widgets/body_header.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/screen_title.dart';

class GameTickets extends StatefulWidget {
  final String? appbarTitle;
  const GameTickets({super.key, this.appbarTitle});

  @override
  State<GameTickets> createState() => _GameTicketsState();
}

class _GameTicketsState extends State<GameTickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: widget.appbarTitle ?? 'Results',
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BodyHeader(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ScreenTitle(
                        title: 'Game Name',
                        titleSize: 12,
                        subTitleSize: 16,
                        titleFontWeight: FontWeight.w400,
                        titleColor: Theme.of(context).colorScheme.text5,
                        subTitleColor: Theme.of(context).colorScheme.textPrimary,
                        subTitleFontWeight: FontWeight.w600,
                        subTitle: '1 Bed Room Flat at Banana Island'
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Number of Tickets",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.text5,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        "32 Tickets",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.textPrimary,
                            fontWeight: FontWeight.w600
                        ),
                      ),
        
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 24.h,),
            Expanded(
              child: ListView.separated(
                itemCount: 15,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
        
                  return TicketItem();
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16.h,);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
