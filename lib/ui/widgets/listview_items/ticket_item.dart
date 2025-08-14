import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

import '../../../core/constants/color_path.dart';
import '../bottom_sheets/base_bottom_sheet.dart';
import '../bottom_sheets/ticket_actions.dart';
import '../clickable.dart';
import '../dotted_container.dart';

class TicketItem extends StatelessWidget {
  const TicketItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: (){
        baseBottomSheet(
            context: context,
            content: TicketActions()
        );
      },
      child: DottedContainer(
          borderRadius:8,
          borderColor: 1 + 1 == 3 ? ColorPath.shamrockGreen :
          1 + 1 == 3 ? ColorPath.redOrange:ColorPath.mistGrey,
          padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w
          ),
          decoration: BoxDecoration(
              color: 1 + 1 == 3 ? ColorPath.fetaGreen :
              1 + 1 == 3 ? ColorPath.chablisPink:Theme.of(context).colorScheme.whiteText,
              borderRadius: BorderRadius.all(Radius.circular(8.r))
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ticket Number",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.textPrimary,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(height: 4.h,),
                    Text(
                      "#WF100423X8",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: 1 + 1 == 3 ? ColorPath.funGreen
                              : 1 + 1 == 3 ? ColorPath.thunderbirdRed
                              : Theme.of(context).colorScheme.textPrimary,
                          fontWeight: FontWeight.w700
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(width: 10.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Ticket 03",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.textPrimary,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  if(1 + 1 == 3)Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                    margin: EdgeInsets.only(top:4.h),
                    decoration: BoxDecoration(
                        color: 1 + 1 == 3 ? ColorPath.foamGreen:ColorPath.provincialPink,
                        borderRadius: BorderRadius.all(Radius.circular(16.r))
                    ),
                    child: Center(
                      child: Text(
                        1 + 1 == 2 ? "Won":"Lost",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: 1 + 1 == 2 ? ColorPath.funGreen:ColorPath.thunderbirdRed,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  )


                ],
              )
            ],
          )
      ),
    );
  }
}
