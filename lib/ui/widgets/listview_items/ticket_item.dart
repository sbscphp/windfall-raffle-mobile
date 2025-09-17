import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/my_games/claim_prize.dart';

import '../../../core/constants/color_path.dart';
import '../../../core/data/models/game.dart';
import '../../../core/data/models/ticket.dart';
import '../bottom_sheets/base_bottom_sheet.dart';
import '../bottom_sheets/ticket_actions.dart';
import '../clickable.dart';
import '../dotted_container.dart';

class TicketItem extends StatelessWidget {
  final Ticket ticket;
  final bool isInstantGame;
  const TicketItem({super.key, required this.ticket, required this.isInstantGame});

  @override
  Widget build(BuildContext context) {
    final ticketNumber = ticket.ticketNumber ?? 'N/A';
    final status = ticket.status ?? 'N/A';
    final isWon = status.toLowerCase() == 'won';
    final isLost = status.toLowerCase() == 'lost';
    final isPending = status.toLowerCase() == 'pending'; //status value for normal game)
    final prizeName = ticket.prize?.name ?? 'N/A';
    return Clickable(
      onPressed: (){
        baseBottomSheet(
            context: context,
            content: TicketActions(
              ticket: ticket,
              isInstantGame: isInstantGame,
            )
        );
      },
      child: DottedContainer(
          borderRadius:8,
          borderColor: isWon ? ColorPath.shamrockGreen :
          isLost ? ColorPath.brinPink:ColorPath.mistGrey,
          padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w
          ),
          decoration: BoxDecoration(
              color: isWon ? ColorPath.fetaGreen :
             isLost ? ColorPath.chablisPink:Theme.of(context).colorScheme.whiteText,
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
                    FittedBox(
                      child: Text(
                        ticketNumber,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: isWon ? ColorPath.funGreen
                                : isLost? ColorPath.redOrange
                                : Theme.of(context).colorScheme.textPrimary,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(width: 10.w,),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if(!isPending)Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                          decoration: BoxDecoration(
                              color: isWon ? ColorPath.foamGreen
                                  : isLost ? ColorPath.provincialPink
                                  : ColorPath.athensGrey10,
                              borderRadius: BorderRadius.all(Radius.circular(16.r))
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "$status",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: isWon ? ColorPath.funGreen:
                                  isLost ? ColorPath.thunderbirdRed
                                      :ColorPath.oxfordBlue,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    if(isInstantGame && prizeName.toLowerCase() != 'n/a')Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        prizeName,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color:Theme.of(context).colorScheme.textPrimary,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),



                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
