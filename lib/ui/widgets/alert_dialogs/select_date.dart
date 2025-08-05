import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';


import '../../../core/utilities/navigator.dart';
import '../show_flush_bar.dart';

class SelectDate extends StatelessWidget {
  final ValueChanged<String> returningValue;
  final DateTime? initialDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  const SelectDate({super.key, required this.returningValue, this.initialDate, this.minDate, this.maxDate});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: SfDateRangePicker(
          backgroundColor: Colors.white,
          confirmText: 'OK',
          cancelText: 'Cancel',
          minDate: minDate,
          maxDate: maxDate,
          initialSelectedDate: initialDate,
          showActionButtons: true,
          showNavigationArrow: true,
          selectionColor: Theme.of(context).colorScheme.textPrimary,
          rangeSelectionColor: Theme.of(context).colorScheme.textPrimary,
          endRangeSelectionColor: Theme.of(context).colorScheme.textPrimary,
          startRangeSelectionColor: Theme.of(context).colorScheme.textPrimary,
          todayHighlightColor: Theme.of(context).colorScheme.textPrimary,
          onCancel: () {
            popNavigation(context: context);
          },
          onSubmit: (value) {
            if (value == null) {
              showFlushBar(
                context: context,
                message: 'Select a date to proceed',
                success: false,
              );
              return;
            }
            String formattedDate = DateFormat('dd-MM-yyyy').format(value as DateTime);
            returningValue(formattedDate);
            popNavigation(context: context);
          },
          headerStyle: DateRangePickerHeaderStyle(
            backgroundColor: Colors.white,
            textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.textPrimary,
            ),
          ),
          monthViewSettings: DateRangePickerMonthViewSettings(
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700, // Thicker weekday labels
                color: Colors.black,
              ),
            ),
          ),
          selectionTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400, color: Colors.white),
          rangeTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400, color: Colors.red),
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {},
          selectionMode: DateRangePickerSelectionMode.single,
        ),
      ),

    );
  }
}
