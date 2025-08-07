import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';

import '../../../core/constants/color_path.dart';

class ActiveGamesCarousel extends StatelessWidget {
  const ActiveGamesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Container(
          height: 32.h,
          color: ColorPath.redOrange,
          padding: EdgeInsets.symmetric(
              horizontal: 16.w
          ),
          child: Center(
            child: Text(
              "Active Games",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 32.h,
            width: double.infinity,
            color: ColorPath.chablisPink,
            child: Center(
              child: Marquee(
                text: 'Sample text a a a a a  ',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorPath.shaftBlack
                ),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                blankSpace: 60.w,
                velocity:50.0,
                //pauseAfterRound: Duration(seconds: 1),
                //startPadding: 10.0,
                //accelerationDuration: Duration(seconds: 1),
                //accelerationCurve: Curves.linear,
                //decelerationDuration: Duration(milliseconds: 500),
                //decelerationCurve: Curves.easeOut,
              ),
            ),
          ),
        )
      ],
    );
  }
}
