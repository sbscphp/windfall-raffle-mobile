import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utilities/navigator.dart';
import '../custom_button.dart';
import '../show_flush_bar.dart';

class BirthdaySelectorView extends StatefulWidget {
  final ValueChanged<String> returningValue;
  final DateTime? initialDate;
  const BirthdaySelectorView({super.key, this.initialDate, required this.returningValue});

  @override
  State<BirthdaySelectorView> createState() => _BirthdaySelectorViewState();
}

class _BirthdaySelectorViewState extends State<BirthdaySelectorView> {

  String _selectedDate = '';
  late DateTime _initialDate, _dateSelected;
  final DateTime _eighteenYearsAgo = DateTime.now().subtract(const Duration(days: 365 * 18));

  @override
  void initState() {
    _initialDate = widget.initialDate ?? DateTime(1992, 1, 1);
    _dateSelected = _initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 400.h,
          width: double.infinity,
          child: CupertinoDatePicker(
            minimumYear: 1900,
            backgroundColor: Colors.transparent,
            maximumDate:
            DateTime.now(),
            initialDateTime: _initialDate,
            mode:
            CupertinoDatePickerMode
                .date,
            dateOrder:
            DatePickerDateOrder
                .dmy,
            onDateTimeChanged: (dateTime) {
              _dateSelected = dateTime;
              String day = dateTime.day.toString().padLeft(2, '0');
              String month = dateTime.month.toString().padLeft(2, '0');
              String year = dateTime.year.toString();
              //_selectedDate = "$year-$month-$day";
              _selectedDate = "$day-$month-$year";
            },


          ),
        ),
        //SizedBox(height: 5.h,),
        Padding(
          padding: EdgeInsets.only(left: 30.w, bottom: 20.h, right: 30.w),
          child: CustomButton(
            buttonText: 'Select Date',
            onPressed: (){
              if(_selectedDate.isEmpty){
                _dateSelected = _initialDate;
                String day = _initialDate.day.toString().padLeft(2, '0');
                String month = _initialDate.month.toString().padLeft(2, '0');
                String year = _initialDate.year.toString();
                //_selectedDate = "$year-$month-$day";
                _selectedDate = "$day-$month-$year";
              }


              if(_dateSelected.isAfter(_eighteenYearsAgo)){
                showFlushBar(
                    context: context,
                    message: 'You must be at least 18 years to proceed',
                    success: false
                );
                return;
              }
              widget.returningValue(_selectedDate);
              popNavigation(context: context);
            },
          ),
        ),
      ],
    );
  }
}
