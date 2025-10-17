import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/utilities/extensions/color_extensions.dart';

import '../../core/constants/app_asset.dart';
import '../../core/constants/app_dimension.dart';
import '../../core/constants/named_routes.dart';
import '../../core/utilities/navigator.dart';
import '../pages/authentication/login.dart';
import 'custom_button.dart';
import 'custom_svg.dart';

class GuestMessage extends StatelessWidget {
  final String? visitingRoute;
  final String? destinationRoute;
  final String? title;
  final String? subtitle;
  const GuestMessage({super.key, this.title, this.subtitle,  this.visitingRoute, this.destinationRoute});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAssetViewer(asset: AppAsset.emptyNotification, height: 64.h, width: 64.w,),
            SizedBox(height: 8.h,),
            Text(
              title ?? 'Join The Fun',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.textPrimary,
              ),
            ),
            SizedBox(height: 8.h,),
            Text(
              subtitle ?? 'Looks like you’re browsing as a guest. Log in to unlock access to all active draw and instant games. Join the fun — your next big win could be waiting.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.textPrimary.withCustomOpacity(0.45),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h,),
            CustomButton(
              buttonWidth: null,
                buttonText: 'Login to play',
                onPressed: (){
                  pushNavigation(context: context, widget: Login(
                      visitingRoute: visitingRoute,
                    destinationRoute: destinationRoute,
                  ),
                      routeName: NamedRoutes.login
                  );
                }
            )

          ],
        ),
      ),
    );
  }
}
