import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/core/utilities/validator.dart';
import 'package:windfall/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:windfall/ui/widgets/bottom_sheets/custom_bottom_sheet.dart';
import 'package:windfall/ui/widgets/busy_overlay.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/custom_painter/dotted_border.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/custom_text_field.dart';
import 'package:windfall/ui/widgets/display_image.dart';
import 'package:windfall/ui/widgets/screen_title.dart';

import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/profile_vms/profile_vm.dart';
import '../../../core/data/view_models/utility_view_models/lga_details_view_model.dart';
import '../../../core/utilities/image_and_doc_utils.dart';
import '../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/show_flush_bar.dart';

class PersonalInformation extends ConsumerStatefulWidget {
  const PersonalInformation({super.key});

  @override
  ConsumerState<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends ConsumerState<PersonalInformation> {

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final  _email = TextEditingController();
  final _dob = TextEditingController();
  final _phone = TextEditingController();
  String? selectedLga, selectedArea;

  @override
  void initState() {
    final vm = ref.read(profileViewModel);
    //final configVm = ref.read(configViewModel);
    final lgaVm = ref.read(lgaDetailsViewModel);
    if(1+1==2){ //configVm.useLga
      selectedLga = vm.lga;
    }
    if(1+1==2){ //configVm.useLgaArea
      selectedArea = vm.area;
      lgaVm.populateAreas(selectedLga: selectedLga ?? '', refreshUi: false);
    }
    _firstName.text = vm.firstname;
    _lastName.text = vm.lastname;
    _email.text = vm.email;
    _phone.text = vm.phoneNumber;
    _dob.text = vm.dob;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(profileViewModel);
    final lgaVm = ref.watch(lgaDetailsViewModel);
    return BusyOverlay(
      show: vm.state == ViewState.busy,
      child: Scaffold(
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
                Expanded(
                  child: Row(
                    children: [
                      CustomPaint(
                          painter: DottedBorder(
                            color: ColorPath.redOrange,
                            isCircle: true,
                          ),
                          child:DisplayImage(
                            size: 72,
                            borderWidth: 0,
                            image:vm.image,
                            useGradient: false,
                            borderColor: Theme.of(context).colorScheme.whiteText,
                            firstName: vm.firstname,
                            lastName: vm.lastname,
                            fontSize: 32.sp,
                          )
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                '${vm.firstname} ${vm.lastname}',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.textPrimary,
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              'ID: 0014', //todo: ask backend
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorPath.redOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w,),
                Clickable(
                  onPressed: () async{
                    final base64String = await ImageAndDocUtils.pickAndCropImage(context: context);
                    if(base64String != null){
                      await vm.updateProfile(
                          details: {
                            'avatar':base64String
                          }
                      );
                      showFlushBar(
                          context: context,
                          message: vm.message,
                          success: vm.state == ViewState.retrieved

                      );
                    }
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
                        "${vm.hasImage ? "Change":"Upload"} Image",
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
              label: "First Name",
              controller: _firstName,
              enabled: false,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 24.h),
            CustomTextField(
              label: "Last Name",
              controller: _lastName,
              enabled: false,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 24.h),
            CustomTextField(
              label: 'Email Address',
              hintText: 'example@email.com',
              controller: _email,
              enabled: false,
              keyboardType: TextInputType.emailAddress,
              // validator: EmailValidator.validateEmail,
              bottomHintText: "You can’t change or update your email address",
            ),
            SizedBox(height: 24.h),
            CustomTextField(
              label: 'Phone Number',
              hintText: '+234 90 4747 2791',
              keyboardType: TextInputType.number,
              controller: _phone,
              enabled: false,
              validator: FieldValidator.validate,
              inputFormatters: [
                LengthLimitingTextInputFormatter(18),
                NigerianPhoneNumberFormatter()
              ],
              bottomHintText: "You can’t change or update your phone number",
            ),
            SizedBox(height: 24.h),
            CustomTextField(
              label: 'Date of Birth / Age Confirmation',
              hintText: 'April 28, 2000',
              enabled: false,
              controller: _dob,
              keyboardType: TextInputType.text,
              bottomHintText:
                  "You are eligible to play game as you are more than 18years of Age",
            ),
            if(1+1==2)Padding( //configVm.useLga
              padding: EdgeInsets.only(top: 24.h),
              child: CustomDropdown(
                hintText: "Select Resident LGA",
                label: 'L.G.A / L.C.D.A *',
                value: selectedLga,
                onChanged: (value){
                  selectedLga = value;
                  if(1+1==2){ //configVm.useLgaArea
                    selectedArea = null;
                    lgaVm.populateAreas(selectedLga: selectedLga ?? '');
                  }
                },
                items: lgaVm.lgaNames,
              ),
            ),
            if(1+1==2)Padding( //configVm.useLgaArea
              padding: EdgeInsets.only(top: 24.h),
              child: CustomDropdown(
                hintText: "Select Area",
                label: 'Area',
                value: selectedArea,
                onChanged: (value){
                  setState(() {
                    selectedArea = value;
                  });
                },
                items: lgaVm.areas,
              ),
            ),
            SizedBox(height: 48.h),
            CustomButton(
              onPressed: () {

                if(selectedArea == null){ //configVm.useLgaArea && selectedArea == null
                  showFlushBar(
                      context: context,
                      success: false,
                      message: 'Kindly select an area to proceed'
                  );
                  return;
                }


                baseBottomSheet(
                  context: context,
                  content: CustomBottomSheet(
                    title: "Save Changes ? ",
                    subTitle:
                        "Are you sure you want to save and update this new changes? Kindly note that this new changes would override the pre-existing data",
                    firstbuttonText: "Save Changes",
                    secondButtonText: "No, Close",
                    firstButtonOnPressed: ()async{

                      popNavigation(context: context);

                      await vm.updateProfile(
                          details: {
                            "lga": selectedLga,
                            "landmark": selectedArea
                          }
                      );

                      if(vm.state == ViewState.retrieved){
                        popNavigation(context: context);
                      }
                      showFlushBar(
                          context: context,
                          message: vm.message,
                          success: vm.state == ViewState.retrieved

                      );
                    },
                    secondButtonOnPressed: (){
                      popNavigation(context: context);
                    },
                    asset: Image.asset(
                      AppAsset.warning,
                      height: 100.h,
                      width: 100.w,
                    ),
                  ),
                );
              },
              useDottedBorder: true,
              buttonText: "Save and Update Changes",
            ),
            SizedBox(height: 48.h),
          ],
        ),
      ),
    );
  }
}
