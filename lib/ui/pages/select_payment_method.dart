import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/core/data/enum/view_state.dart';
import 'package:windfall/core/data/view_models/checkout_vm.dart';
import 'package:windfall/ui/pages/payment_checkout.dart';
import 'package:windfall/ui/widgets/busy_overlay.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/media_placeholder.dart';
import 'package:windfall/ui/widgets/show_flush_bar.dart';

import '../../core/constants/named_routes.dart';
import '../../core/data/view_models/payment_vms/payment_vm.dart';
import '../../core/utilities/navigator.dart';
import '../widgets/app_loader.dart';
import '../widgets/custom_radio_button.dart';
import '../widgets/error_state.dart';


class SelectPaymentMethod extends ConsumerStatefulWidget {
  const SelectPaymentMethod({super.key});

  @override
  ConsumerState<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends ConsumerState<SelectPaymentMethod> {

  @override
  void initState() {
    ref.read(paymentViewModel).resetPaymentVariables();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(paymentViewModel);
    return BusyOverlay(
      show: vm.secondState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
            context: context,
            title: 'Pay Now',
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingRight, vertical: AppDimension.paddingTop),
          child: SafeArea(
            child: Builder(
              builder: (context) {
                if(vm.thirdState == ViewState.busy){
                  return const Center(
                    child: AppLoader(),
                  );
                }

                if(vm.thirdState == ViewState.retrieved){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pay Via',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).colorScheme.textPrimary
                              ),
                            ),
                            SizedBox(height: 8.h,),
                            Text(
                              'Select a payment option that best suit you ',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.textSecondary
                              ),
                            ),
                            SizedBox(height: 24.h,),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.separated(
                                      itemCount: vm.paymentMethods.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index) {
                                        final paymentMethod = vm.paymentMethods[index];
                                        final slug = paymentMethod.slug;
                                        final name = paymentMethod.name ?? 'N/A';
                                        final image = paymentMethod.logo ?? '';
                                        final isSelected = slug?.toLowerCase() == vm.selectedPaymentMethod?.slug?.toLowerCase();
                                        return Clickable(
                                          onPressed: (){
                                            vm.selectedPaymentType = null;
                                            vm.selectedPaymentMethod = paymentMethod;
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(color: ColorPath.athensGrey2, width: 1.w),
                                              borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 22.26.h,
                                                        width: 32.w,
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.all(Radius.circular(2.78.r)),
                                                          child: CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            height: double.infinity,
                                                            width: double.infinity,
                                                            imageUrl: image,
                                                            placeholder: (context, url) => const MediaPlaceholder(),
                                                            errorWidget: (context, url, error) => const MediaPlaceholder(),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 8.w,),
                                                      Expanded(
                                                        child: Text(
                                                          name,
                                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                              fontWeight: FontWeight.w700,
                                                              color: Theme.of(context).colorScheme.textPrimary
                                                          ),
                                                        ),
                                                      )


                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10.w,),
                                                CustomRadioButton(
                                                  disableClick: true,
                                                  value: isSelected,
                                                )

                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(height: 17.h,);
                                      },
                                    ),
                                    if(vm.selectedPaymentMethod != null)paymentChannels(context, vm)

                                  ],
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      CustomButton(
                          buttonText: 'Continue',
                          useDottedBorder: true,
                          onPressed: () async{
                            if(vm.selectedPaymentMethod == null){
                              showFlushBar(
                                  context: context,
                                  message: 'Kindly select a payment method to proceed',
                                  success: false
                              );
                              return;
                            }

                            if(vm.selectedPaymentType == null){
                              showFlushBar(
                                  context: context,
                                  message: 'Kindly select a payment type to proceed',
                                  success: false
                              );
                              return;
                            }

                            await vm.initiateCheckout(
                                checkoutVm: ref.read(checkoutViewModel)
                            );
                            if(vm.secondState == ViewState.retrieved){
                              pushNavigation(context: context, widget: const PaymentCheckout(), routeName: NamedRoutes.paymentCheckout);
                            }
                            else{
                              showFlushBar(
                                  context: context,
                                  message: vm.message,
                                  success: false
                              );
                            }
                          }
                      ),

                    ],
                  );
                }

                if(vm.thirdState == ViewState.error){
                  return Center(
                    child: ErrorState(
                        message: vm.paymentMethodMessage,
                        onPressed: ()=>vm.fetchPaymentMethods()
                    ),
                  );
                }

                return const SizedBox();

              }
            ),
          ),
        ),
      ),
    );
  }

  paymentChannels(BuildContext context, PaymentVm vm){
    return BounceInUp(
      duration: const Duration(milliseconds: 800),
      delay: const Duration(milliseconds: 200),
      child: Padding(
        padding: EdgeInsets.only(top: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a Payment Type',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.textPrimary
              ),
            ),
            // SizedBox(height: 8.h,),
            // Text(
            //   'Select a payment option that best suit you ',
            //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
            //       fontWeight: FontWeight.w400,
            //       color: Theme.of(context).colorScheme.textSecondary
            //   ),
            // ),
            SizedBox(height: 24.h,),
            ListView.separated(
              itemCount: vm.paymentTypes.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final paymentType = vm.paymentTypes[index];
                final isSelected = paymentType.toLowerCase() == vm.selectedPaymentType?.toLowerCase();
                return Clickable(
                  onPressed: (){
                    vm.selectedPaymentType = paymentType;
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: ColorPath.athensGrey2, width: 1.w),
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  paymentType.replaceAll('_', ' '),
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).colorScheme.textPrimary
                                  ),
                                ),
                              )


                            ],
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        CustomRadioButton(
                          disableClick: true,
                          value: isSelected,
                        )

                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 17.h,);
              },
            ),
          ],
        ),
      ),
    );
  }
}
