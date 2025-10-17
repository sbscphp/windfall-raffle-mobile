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
        padding: EdgeInsets.only(top: 56.h, left: AppDimension.paddingLeft, right: AppDimension.paddingRight),
        child: Column(
          children: [
            CustomAssetViewer(asset: AppAsset.avatar, height: 100.h, width: 100.w,),
            SizedBox(height: 32.h,),
            Text(
              title ?? 'Join The Fun',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.textPrimary.withCustomOpacity(0.85),
              ),
            ),
            SizedBox(height: 8.h,),
            Text(
              subtitle ?? 'Sign up or log in to unlock exclusive deals, personalised recommendations and enjoy seamless shopping experience.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.textPrimary.withCustomOpacity(0.45),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h,),
            CustomButton(
                buttonText: 'Login',
                useDottedBorder: true,
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
