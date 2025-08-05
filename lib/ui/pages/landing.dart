import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/data/view_models/landing_view_model.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/authentication/login.dart';
import 'package:windfall/ui/pages/authentication/sign_up.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';

import '../../core/constants/color_path.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_dot.dart';

class Landing extends ConsumerStatefulWidget {
  const Landing({super.key});

  @override
  ConsumerState<Landing> createState() => _LandingState();
}

class _LandingState extends ConsumerState<Landing> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(landingViewModel);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
            Swiper(
              autoplay: true,
              autoplayDisableOnInteraction: true,
              controller: vm.swiperController,
              itemCount:vm.images.length,
              duration: 1000,
              //autoplayDelay: 3000, // Delay in milliseconds
              curve: Curves.easeInOut,
              itemHeight: double.infinity,
              itemWidth: double.infinity,
              onIndexChanged: (index)=>vm.updateIndex(index),
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  vm.images[index],
                  fit: BoxFit.cover,
                );

              },
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 48.h,
                horizontal: 32.w
              ),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    vm.titles[vm.currentIndex],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: 8.h,),
                  Text(
                    vm.subtitles[vm.currentIndex],
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorPath.roseWhite
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h,),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                          vm.images.length,
                              (index) => CustomDot(
                            height: 12,
                            width: 12,
                            activeColor: Theme.of(context).colorScheme.brandColor,
                            inactiveColor: ColorPath.roseWhite,
                            useRoundCircles: true,
                            isActive: vm.currentIndex == index,
                          )),
                    ),
                  ),
                  SizedBox(height: 24.h,),
                  Row(
                    children: [
                      Expanded(
                        child:  CustomButton(
                            buttonText:'Create Account',
                            onPressed: (){
                              pushNavigation(context: context, widget: const SignUp(), routeName: NamedRoutes.signUp);
                            }
                        ),
                      ),
                      SizedBox(width: 24.w,),
                      Expanded(
                        child:  CustomButton(
                          bgColor: Colors.white,
                            buttonTextColor: Theme.of(context).colorScheme.brandColor,
                            buttonText:'Log in',
                            onPressed: (){
                              pushNavigation(context: context, widget: const Login(), routeName: NamedRoutes.login);
                            }
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
