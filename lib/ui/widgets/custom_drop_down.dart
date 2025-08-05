import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

import '../../core/constants/color_path.dart';


class CustomDropdown extends StatelessWidget {

  final String? hintText;
  //final String? Function(String?)? validator;
  final int maxLines;
  final List<String> items;
  final String? value;
  final double? textSize;
  final bool isCompulsory;
  final FocusNode? focusNode;
  final Function(String?)? onChanged;

  const CustomDropdown(
      {super.key,
        this.hintText,
        //this.validator,
        this.textSize,
        this.focusNode,
        this.maxLines = 1,
        this.isCompulsory = false,
        required this.items, this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return  Container(
      height: 52.h,
      //padding: EdgeInsets.symmetric(horizontal: 16.w, ),
      decoration: BoxDecoration(
          color: colorScheme.textFieldFillColor,
          borderRadius: BorderRadius.all(
            Radius.circular(6.r),
          ),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              focusNode: focusNode,
              value: value,
              //validator: validator,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 16.w, right: 16.w,  top: 6.h, bottom: 6.h),
                //labelText: hintText,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                label: Row(
                  children: [
                    Text(
                      hintText ?? 'Select',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.textPrimary
                      ),
                    ),
                    if(isCompulsory)SizedBox(width: 5.w,),
                    if(isCompulsory)Text(
                      '*',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorPath.redOrange
                      ),
                    ),

                  ],
                ),
                //contentPadding: EdgeInsets.only(top: 5.h,),
                labelStyle: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.textPrimary
                ),
              ),
              items: items.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(
                    dropDownStringItem,
                    style: textTheme.bodyMedium?.copyWith(
                        fontSize: textSize?.sp,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.brandColor
                    ),
                  ),
                );
              }).toList(),

              style: textTheme.bodyMedium?.copyWith(
                  fontSize: textSize?.sp,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.brandColor
              ),
              elevation: 1,
              icon: const SizedBox(),
              onChanged: onChanged,

            ),
          ),
          Padding(
            padding:  EdgeInsets.only(right: 16.w),
            child: Icon(Icons.keyboard_arrow_down, color: colorScheme.textPrimary, size: 20.w,),
          )
        ],
      ),
    );
  }
}
