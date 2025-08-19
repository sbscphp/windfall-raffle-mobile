import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:windfall/ui/widgets/bottom_sheets/claim_successful_bottomsheet.dart';
import 'package:windfall/ui/widgets/cart/row_description_item.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/custom_check_box.dart';
import 'package:windfall/ui/widgets/custom_painter/dotted_border.dart';
import 'package:windfall/ui/widgets/custom_text_field.dart';
import 'package:windfall/ui/widgets/form_media_uploader.dart';
import 'package:windfall/ui/widgets/listview_items/ticket_item.dart';
//todo::: Do I have to enter my records each time I win a prize?

class ClaimPrize extends StatefulWidget {
  const ClaimPrize({super.key});

  @override
  State<ClaimPrize> createState() => _ClaimPrizeState();
}

class _ClaimPrizeState extends State<ClaimPrize> {
  var name = "Danny";
  var step = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Claim Prize'),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(
            top: 20.h,
            left: AppDimension.paddingLeft,
            right: AppDimension.paddingRight,
          ),
          children: [
            Text.rich(
              TextSpan(
                text: "Congratulations $name! ",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ColorPath.redOrange,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                    text: "You have won a House in the Windfall Raffle.\n",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: ColorPath.blackyBlack,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: "Claim your rewards with ease.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.textSecondary,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            TicketItem(showResultTag: true, clickable: false),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Step $step: ",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorPath.redOrange,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: formTitle(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(width: 4.w),
                Icon(Icons.south, color: ColorPath.redOrange, size: 16),
              ],
            ),
            SizedBox(height: 24.h),
            CustomPaint(
              painter: DottedBorder(
                color: ColorPath.redOrange,
                strokeWidth: 0.95,
                dashWidth: 1.75,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                ),
                sides: {DottedBorderSide.top},
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: handleFormView(),
              ),
            ),
            SizedBox(height: 16.h),
            CustomButton(
              onPressed: () {
                if (step == 3) {
                  baseBottomSheet(
                    context: context,
                    content: ClaimSuccessfulBottomsheet(),
                  );
                  return;
                }
                setState(() {
                  step += 1;
                });
              },
              useDottedBorder: true,
              childWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    step < 3 ? "Next" : "Submit Claim",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: ColorPath.roseWhite,
                    ),
                  ),
                  step < 3
                      ? Row(
                          children: [
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.east,
                              color: ColorPath.roseWhite,
                              weight: 3,
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),
            SizedBox(height: 42.h),
          ],
        ),
      ),
    );
  }

  Widget handleFormView() {
    switch (step) {
      case 1:
        return form1();
      case 2:
        return form2();
      case 3:
        return form3();
      default:
        return SizedBox();
    }
  }

  String formTitle() {
    switch (step) {
      case 1:
        return "Identity verification";
      case 2:
        return "Ownership handover details";
      case 3:
        return "Review and submit";
      default:
        return "";
    }
  }

  Widget form1() => Column(
    children: [
      CustomTextField(label: "Your Full Name", hintText: "Enter Full Name"),
      SizedBox(height: 16.h),
      Clickable(
        onPressed: () {},
        child: CustomTextField(
          label: "Date of Birth",
          hintText: "Select Date of Birth",
          enabled: false,
        ),
      ),
      SizedBox(height: 16.h),
      CustomTextField(
        label: "Phone Number",
        hintText: "Enter Phone Number",
        keyboardType: TextInputType.phone,
      ),
      SizedBox(height: 16.h),
      FormMediaUploader(
        title: "Court Issued Id",
        titleExtension: "(NIN or drivers license)",
      ),
      SizedBox(height: 16.h),
      FormMediaUploader(title: "Proof of Address"),
    ],
  );

  Widget form2() => Column(
    children: [
      // CustomTextField(label: "Your Full Name", hintText: "Enter Full Name"),
      // SizedBox(height: 16.h),
      FormMediaUploader(title: "Passport photo"),
      SizedBox(height: 16.h),
      CustomTextField(
        label: "Your address",
        hintText: "Enter Address",
        keyboardType: TextInputType.phone,
      ),
      SizedBox(height: 16.h),
      CustomTextField(
        label: "Email address",
        hintText: "Enter email address",
        keyboardType: TextInputType.phone,
      ),
      SizedBox(height: 30.h),
      Row(
        children: [
          CustomCheckBox(
            height: 24,
            width: 24,
            onchanged: (value) {
              //vm.is18yrs = value;
            },
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'I confirm that the information provided is true and accurate.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.textSecondary,
              ),
            ),
          ),
        ],
      ),
    ],
  );

  Widget form3() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Column(
      children: [
        Text(
          "Confirm the following details before you submit",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        SizedBox(height: 30),
        RowDescriptionItem(
          description: "Raffle :",
          fontSize: 14.sp,
          descriptionColor: Theme.of(context).colorScheme.textPrimary,
          item: Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              SizedBox(width: 15.w),
              Text("3 bedroom house in lekki "),
            ],
          ),
        ),
        SizedBox(height: 24),
        RowDescriptionItem(
          description: "Winner :",
          fontSize: 14.sp,
          descriptionColor: Theme.of(context).colorScheme.textPrimary,
          item: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 15.w),
              Text("Adekunle ibrahim"),
            ],
          ),
        ),
        SizedBox(height: 24),
        RowDescriptionItem(
          description: "Date of birth :",
          fontSize: 14.sp,
          descriptionColor: Theme.of(context).colorScheme.textPrimary,
          item: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 15.w),
              Text("05/10/1991"),
            ],
          ),
        ),
        SizedBox(height: 24),
        RowDescriptionItem(
          description: "Ownership :",
          fontSize: 14.sp,
          descriptionColor: Theme.of(context).colorScheme.textPrimary,
          item: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 15.w),
              Flexible(
                child: Text.rich(
                  textAlign: TextAlign.end,
                  TextSpan(
                    text: "Legal name - ",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.textSecondary,
                    ),

                    children: [
                      TextSpan(
                        text: "Adekunle ibrahim olamide",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        RowDescriptionItem(
          description: "Address :",
          fontSize: 14.sp,
          descriptionColor: Theme.of(context).colorScheme.textPrimary,
          item: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 15.w),
              Text("13 bode thomas surulere lagos "),
            ],
          ),
        ),
        SizedBox(height: 24),
        RowDescriptionItem(
          description: "Contact :",
          fontSize: 14.sp,
          crossAxisAlignment: CrossAxisAlignment.center,
          descriptionColor: Theme.of(context).colorScheme.textPrimary,
          item: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 15.w),
                  Text("adaekunleibrahim@gmail.com"),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 15.w),
                  Text("+234 6784333329"),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 30.h),
        Row(
          children: [
            CustomCheckBox(
              height: 24,
              width: 24,
              onchanged: (value) {
                //vm.is18yrs = value;
              },
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                'I accept the terms, conditions and raffle policy.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.textSecondary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30.h),
      ],
    ),
  );
}
