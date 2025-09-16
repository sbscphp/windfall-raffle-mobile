import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/view_models/game_vms/my_games_vm.dart';
import 'package:windfall/ui/pages/receipt/payment_receipt.dart';

import '../../core/constants/app_dimension.dart';
import '../../core/constants/color_path.dart';
import '../../core/constants/named_routes.dart';
import '../../core/data/enum/view_state.dart';
import '../../core/data/view_models/profile_vms/profile_vm.dart';
import '../../core/data/view_models/referral_vm.dart';
import '../../core/utilities/navigator.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/render_lottie.dart';


class OrderConfirmation extends ConsumerStatefulWidget {
  final bool paymentSuccessful;
  const OrderConfirmation({super.key, required this.paymentSuccessful});

  @override
  ConsumerState<OrderConfirmation> createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends ConsumerState<OrderConfirmation> {

  @override
  void initState() {
    if(widget.paymentSuccessful){
      SchedulerBinding.instance.addPostFrameCallback((_) {
        //fetch-profile
        final profileVm = ref.read(profileViewModel);
        final referralVm = ref.read(referralViewModel);
        profileVm.fetchProfile(showBusyState: false).then((value) async {
          if(profileVm.thirdState == ViewState.retrieved){
            //todo: fetch spend limit data
            //update spend-limit object
            // final spendLimitVm = ref.read(spendLimitViewModel);
            // spendLimitVm.spendLimit = profileVm.user?.spendLimitStatus;

            //update referral data
            referralVm.fetchEarnedHistory();
            referralVm.fetchUsedHistory();
          }
        });

        //fetch my games
        ref.read(myGamesViewModel).fetchMyGames();


        //fetch notifications
        //todo:fetch notifications
      });
    }

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          //title: '',
          // actions: [
          //   const HomeIcon()
          // ]
      ),
      body: Padding(
        padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, bottom:49.h, top: 50.h),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RenderLottie(
                        lottieAsset: 'assets/json/${widget.paymentSuccessful ? 'successful':'failed'}.json',
                        repeat: false,
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                      ),
                    SizedBox(height: 8.h,),
                    Text(
                      widget.paymentSuccessful ? 'Payment Successful':'Payment Failed',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.textPrimary
                      ),
                    ),
                    SizedBox(height: 8.h,),
                    Text(
                      widget.paymentSuccessful ? 'Congratulations, your payment is successful.'
                      :'So sorry, your payment failed',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.textPrimary
                      ),
                      textAlign: TextAlign.center,
                    ),



                  ],
                ),
              ),
              Column(
                children: [
                  CustomButton(
                    useDottedBorder: true,
                      buttonText: widget.paymentSuccessful ? 'View Order Details':'Try Again',
                      onPressed: (){
                        if(widget.paymentSuccessful){
                          pushNavigation(
                            context: context,
                            widget: PaymentReceipt(),
                            routeName: NamedRoutes.paymentReceipt,
                          );
                        }else{
                          popUntilNavigation(context: context, route: NamedRoutes.selectPaymentMethod);
                        }
                      }
                  ),
                  SizedBox(height: 12.h,),
                  CustomButton(
                      buttonText: 'Home',
                      useBorderColor: true,
                      borderColor: ColorPath.athensGrey2,
                      buttonTextColor: Theme.of(context).colorScheme.textPrimary,
                      onPressed: (){
                        popUntilNavigation(context: context, route: NamedRoutes.bottomNav);
                      }
                  ),
                ],
              )
            ],
          ),
        ),
      ),

    );
  }
}
