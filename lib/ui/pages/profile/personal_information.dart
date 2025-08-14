import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/core/utilities/validator.dart';
import 'package:windfall/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:windfall/ui/widgets/bottom_sheets/custom_bottom_sheet.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/custom_painter/dotted_border.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/custom_text_field.dart';
import 'package:windfall/ui/widgets/display_image.dart';
import 'package:windfall/ui/widgets/screen_title.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Personal Information',
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: AppDimension.paddingTop,
        ),
        children: [
          ScreenTitle(
            title: "Personal Information ",
            subTitle: "Edit your personal information with ease today.  ",
            subTitleSize: 12.sp,
          ),
          SizedBox(height: 32.h),
          Row(
            children: [
              //todo handle file image upload
              CustomPaint(
                painter: DottedBorder(
                  color: ColorPath.redOrange,
                  isCircle: true,
                ),
                child: 1 + 1 == 2
                    ? DisplayImage(
                        size: 54,
                        borderWidth: 0,
                        image:
                            'https://mir-s3-cdn-cf.behance.net/user/276/888fd91082619909.61d2827bbd7a2.jpg',
                        useGradient: false,
                        borderColor: Theme.of(context).colorScheme.whiteText,
                        firstName: 'A',
                        lastName: 'D',
                        fontSize: 14.sp,
                      )
                    : Container(
                        height: 54.h,
                        width: 54.w,
                        decoration: BoxDecoration(
                          color: ColorPath.fairPink,
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: CustomSvg(asset: AppAsset.avatar)),
                      ),
              ),
              SizedBox(width: 19.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Damilola, A. 🌹',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.brandColor,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'ID: 9940🚀 ',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Clickable(
                onPressed: () {
                  // Handle change image action
                },
                child: Row(
                  children: [
                    CustomSvg(
                      asset: AppAsset.camera,
                      width: 16.sp,
                      height: 16.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Change Image",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        decoration: TextDecoration.underline,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          CustomTextField(
            label: "Full Name",
            validator: UsernameValidator.validateUsername,
          ),
          SizedBox(height: 24.h),
          CustomTextField(
            label: 'Email Address',
            hintText: 'example@email.com',
            //controller: _loginChoice,
            // keyboardType: TextInputType.emailAddress,
            // validator: EmailValidator.validateEmail,
            bottomHintText: "You can’t change or update your email address",
          ),
          SizedBox(height: 24.h),
          CustomTextField(
            label: 'Phone Number',
            hintText: '+234 90 4747 2791',
            //controller: _loginChoice,
            // keyboardType: TextInputType.emailAddress,
            // validator: EmailValidator.validateEmail,
            bottomHintText: "You can’t change or update your phone number",
          ),
          SizedBox(height: 24.h),
          CustomTextField(
            label: 'Date of Birth / Age Confirmation',
            hintText: 'April 28, 2000',
            //controller: _loginChoice,
            // keyboardType: TextInputType.emailAddress,
            // validator: EmailValidator.validateEmail,
            bottomHintText:
                "You are eligible to play game as you are more than 18years of Age",
          ),
          SizedBox(height: 24.h),
          CustomTextField(
            label: "L.G.A / L.C.D.A ",
            // validator: UsernameValidator.validateUsername,
          ),
          SizedBox(height: 24.h),
          CustomTextField(
            label: "State",
            // validator: UsernameValidator.validateUsername,
          ),
          SizedBox(height: 48.h),
          CustomButton(
            onPressed: () {
              // confirmm save changes bottomsheet
              // baseBottomSheet(
              //   context: context,
              //   content: CustomBottomSheet(
              //     title: "Save Changes ? ",
              //     subTitle:
              //         "Are you sure you want to save and update this new changes? Kindly note that this new changes would override the pre-existing data ",
              //     firstbuttonText: "Save Changes",
              //     secondButtonText: "No, Close",
              //   ),
              // );
              // success bottomsheet
              baseBottomSheet(
                context: context,
                content: CustomBottomSheet(
                  title: "New Changes Saved ",
                  subTitle:
                      "Congratulation, you have successfully saved and updated new changes",
                  firstbuttonText: "Manage Settings",
                  secondButtonText: "Explore Games",
                  asset: AppAsset.success,
                ),
              );
            },
            useDottedBorder: true,
            buttonText: "Save and Update Changes",
          ),
          SizedBox(height: 48.h),
        ],
      ),
    );
  }
}
