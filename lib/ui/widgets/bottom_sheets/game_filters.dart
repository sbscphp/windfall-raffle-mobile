import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/view_models/game_vms/game_filters_vm.dart';
import 'package:windfall/ui/widgets/alert_dialogs/select_date.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/utilities/navigator.dart';
import '../alert_dialogs/base_dialog.dart';
import '../clickable.dart';
import '../custom_button.dart';
import '../custom_svg.dart';
import '../screen_title.dart';
import '../show_flush_bar.dart';

class GameFilters extends ConsumerStatefulWidget {
  const GameFilters({super.key});

  @override
  ConsumerState<GameFilters> createState() => _GameFiltersState();
}

class _GameFiltersState extends ConsumerState<GameFilters> {

  String? _startDate, _endDate;
  String? selectedDrawDateOption;
  String? selectedCategoryOption;

  @override
  void initState() {
    final vm = ref.read(gameFiltersViewModel);
    debugPrint('filter options::::${vm.filterOptions.toString()}>>>');

    //init selected category
    selectedCategoryOption = vm.filterOptions['type'];

    //init selected draw date
    selectedDrawDateOption = vm.filterOptions['time_preset_real'];

    //init start date
    _startDate = vm.filterOptions['start_date'];

    //init end date
    _endDate = vm.filterOptions['end_date'];

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(gameFiltersViewModel);
    return Container(
      padding: EdgeInsets.only(bottom: 32.h, top: 32.h, left: 16.w, right: 16.w),
      width: double.infinity,
      child: SafeArea(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ScreenTitle(
                    title: 'Filter',
                    subTitle: 'Filter by following options.'
                ),
                SizedBox(width: 20.w,),
                IgnorePointer(
                  ignoring: vm.state == ViewState.busy,
                  child: Clickable(
                      onPressed: ()=>popNavigation(context: context),
                      child: CustomSvg(asset: AppAsset.close, height: 30.h, width: 30.w,)),
                ),
              ],
            ),
            SizedBox(height: 16.h,),
            categories(context: context, vm: vm),
            SizedBox(height: 20.h,),
            drawDate(context: context, vm: vm),
            SizedBox(height: 16.h,),
            Text(
              'Enter Custom Date',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(height: 8.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.textPrimary
                        ),
                      ),
                      SizedBox(height: 6.h,),
                      Clickable(
                        onPressed: (){
                          // showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return selectDateDialog(
                          //           context: context,
                          //           initialDate: DateFormat("dd-MM-yyyy").tryParse(_startDate ?? ''),
                          //           returningValue: (value){
                          //             if(value != null){
                          //               setState(() {
                          //                 _startDate = value;
                          //               });
                          //             }
                          //           }
                          //       );
                          //     });
                          baseDialog(
                            isDismissible: true,
                            context: context,
                            content: SelectDate(
                                initialDate: DateFormat("dd-MM-yyyy").tryParse(_startDate ?? ''),
                                returningValue: (value){
                                  setState(() {
                                    _startDate = value;
                                  });
                                                                }
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorPath.mischkaGrey, width: 1.w),
                              borderRadius: BorderRadius.all(Radius.circular(8.r))
                          ),
                          child:Text(
                            _startDate ?? 'DD/MM/YY',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.textPrimary
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'End Date:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.textPrimary
                        ),
                      ),
                      SizedBox(height: 6.h,),
                      Clickable(
                        onPressed: (){
                          // showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return selectDateDialog(
                          //           context: context,
                          //           initialDate: DateFormat("dd-MM-yyyy").tryParse(_endDate ?? ''),
                          //           returningValue: (value){
                          //             if(value != null){
                          //               setState(() {
                          //                 _endDate = value;
                          //               });
                          //             }
                          //           }
                          //       );
                          //     });

                          baseDialog(
                            isDismissible: true,
                            context: context,
                            content: SelectDate(
                                initialDate: DateFormat("dd-MM-yyyy").tryParse(_endDate ?? ''),
                                returningValue: (value){
                                  setState(() {
                                    _endDate = value;
                                  });
                                }
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorPath.mischkaGrey, width: 1.w),
                              borderRadius: BorderRadius.all(Radius.circular(8.r))
                          ),
                          child:Text(
                            _endDate ?? 'DD/MM/YY',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.textPrimary
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h,),
            Consumer(
              builder: (context, ref, child){
                return  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButton(
                        useDottedBorder: true,
                        buttonText: 'Apply Filter',
                        showLoader: vm.state == ViewState.busy,
                        onPressed: () async{

                          if(_startDate == null && _endDate != null){
                            showFlushBar(
                              context: context,
                              success: false,
                              message: 'Select a start date to proceed',
                            );
                            return;
                          }

                          if(_startDate != null && _endDate == null){
                            showFlushBar(
                              context: context,
                              success: false,
                              message: 'Select an end date to proceed',
                            );
                            return;
                          }

                          if(_startDate != null && _endDate != null){

                            final startDate = DateFormat("dd-MM-yyyy").tryParse(_startDate ?? '');
                            final endDate = DateFormat("dd-MM-yyyy").tryParse(_endDate ?? '');

                            if(!startDate!.isBefore(endDate!)) {
                              showFlushBar(
                                context: context,
                                success: false,
                                message: 'Start date must be before end date',
                              );
                              return;
                            }

                            if(!endDate.isAfter(startDate)){
                              showFlushBar(
                                context: context,
                                success: false,
                                message: 'End date must be after start date.',
                              );
                              return;
                            }
                          }

                          if(_startDate == null && _endDate == null && selectedCategoryOption == null && selectedDrawDateOption == null){
                            showFlushBar(
                              context: context,
                              success: false,
                              message: 'Select filter options to proceed',
                            );
                            return;
                          }

                          //set selected filter options
                          vm.setFilterOptions(
                              selectedCategory: selectedCategoryOption,
                              selectedDrawDate: selectedDrawDateOption,
                              startDate: _startDate,
                              endDate: _endDate
                          );

                          await vm.fetchFilteredResults();
                          if(vm.state == ViewState.retrieved){
                            //close bottom-sheet
                            popNavigation(context: context);
                            //display success message
                            showFlushBar(
                              context: context,
                              message: vm.message,
                            );
                          }
                          else{
                            //display error message
                            showFlushBar(
                                context: context,
                                message: vm.message,
                                success: false
                            );
                          }

                        }
                    ),
                    // SizedBox(height: 16.h,),
                    // CustomButton(
                    //     buttonText: 'No. Cancel',
                    //     borderColor: ColorPath.mischkaGrey,
                    //     buttonTextColor: Theme.of(context).colorScheme.subTextSecondary,
                    //     buttonTextSize: 16,
                    //     onPressed: () {
                    //       popNavigation(context: context);
                    //     }
                    // ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  categories({required BuildContext context, required GameFiltersVm vm}){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: ColorPath.redOrange
          ),
        ),
        SizedBox(height: 16.h,),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: vm.categories.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final category = vm.categories[index];
            final isSelected =  selectedCategoryOption?.toLowerCase() == category.toLowerCase();
            return Row(
              children: [
                Clickable(
                  onPressed: (){
                    selectedCategoryOption = category;
                    setState(() {});
                  },
                  child: Container(
                    height: 18.h,
                    width: 18.w,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            color: ColorPath.mischkaGrey, width: 1.w),
                        borderRadius:
                        BorderRadius.all(Radius.circular(4.r))),
                    child: Center(
                      child:isSelected
                          ? Icon(
                        Icons.check,
                        color: ColorPath.redOrange,
                        size: 12,
                      )
                          : Container(),
                    ),
                  ),
                ),
                SizedBox(width: 8.w,),
                Text(
                  "$category Games",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.textPrimary
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 16.h,
            );
          },
        )
      ],
    );
  }

  drawDate({required BuildContext context, required GameFiltersVm vm}){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Draw Date',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: ColorPath.redOrange
          ),
        ),
        SizedBox(height: 16.h,),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: vm.drawDates.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final drawDate = vm.drawDates[index];
            final isSelected =  selectedDrawDateOption?.toLowerCase() == drawDate.toLowerCase();
            return Row(
              children: [
                Clickable(
                  onPressed: (){
                    selectedDrawDateOption = drawDate;
                    setState(() {});
                  },
                  child: Container(
                    height: 18.h,
                    width: 18.w,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            color: ColorPath.mischkaGrey, width: 1.w),
                        borderRadius:
                        BorderRadius.all(Radius.circular(4.r))),
                    child: Center(
                      child:isSelected
                          ? Icon(
                        Icons.check,
                        color: ColorPath.redOrange,
                        size: 12,
                      )
                          : Container(),
                    ),
                  ),
                ),
                SizedBox(width: 8.w,),
                Text(
                  drawDate,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.textPrimary
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 16.h,
            );
          },
        )
      ],
    );
  }



}