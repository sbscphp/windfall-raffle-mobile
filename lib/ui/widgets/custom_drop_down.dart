import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

import '../../core/constants/color_path.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  final double? labelSize;
  final FontWeight labelFontWeight;
  final Color? labelColor;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;
  final String hintText;
  final String bottomHintText;
  final double? textSize;
  final Color? bottomHintColor;
  final bool enabled;
  final bool readOnly;
  final bool isCompulsory;
  final FocusNode? focusPointer;
  final bool showLabel;

  const CustomDropdown({
    super.key,
    this.label = '',
    this.labelSize,
    this.labelFontWeight = FontWeight.w400,
    this.labelColor,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.hintText = '',
    this.bottomHintText = '',
    this.textSize,
    this.bottomHintColor,
    this.enabled = true,
    this.readOnly = false,
    this.isCompulsory = true,
    this.focusPointer,
    this.showLabel = true,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel)
          Row(
            children: [
              Text(
                widget.label,
                style: textTheme.bodyMedium?.copyWith(
                  color: widget.labelColor ?? colorScheme.textFieldLabel,
                  fontWeight: widget.labelFontWeight,
                ),
              ),
              if (widget.isCompulsory) SizedBox(width: 5.w),
              if (widget.isCompulsory)
                Text(
                  '*',
                  style: textTheme.bodyMedium?.copyWith(
                    color: ColorPath.redOrange,
                    fontSize: widget.labelSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        if (widget.showLabel) SizedBox(height: 6.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.textFieldFillColor,
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
          ),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            focusNode: widget.focusPointer,
            value: widget.value,
            validator: (value) {
              if (widget.validator != null) {
                final error = widget.validator!(value);
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _errorText = error;
                  });
                });
              }
              return null;
            },
            onChanged: widget.enabled && !widget.readOnly ? widget.onChanged : null,
            decoration: InputDecoration(
              errorText: null,
              errorMaxLines: 3,
              hintText: widget.hintText,
              hintStyle: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: colorScheme.textFieldHint,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              suffixIconConstraints: BoxConstraints(
                minWidth: 16.w,
                minHeight: 16.h,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 16.w,
                minHeight: 16.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: _errorText != null ? ColorPath.redOrange : colorScheme.textFieldBorder,
                  width: 1.w,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _errorText != null ?ColorPath.redOrange: colorScheme.textFieldBorder,
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: colorScheme.textFieldBorder, width: 0.5.w),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: _errorText != null ? ColorPath.redOrange : colorScheme.textFieldBorder,
                  width: 1.w,
                ),
              ),
            ),
            icon: Padding(
              padding: EdgeInsets.only(right: 0.w),
              child: Icon(Icons.keyboard_arrow_down, color: colorScheme.blackText, size: 20.w),
            ),
            items: widget.items.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(
                  dropDownStringItem,
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: widget.textSize?.sp,
                    fontWeight: FontWeight.w400,
                    color: colorScheme.textPrimary,
                  ),
                ),
              );
            }).toList(),
            style: textTheme.bodyLarge?.copyWith(
              fontSize: widget.textSize?.sp,
              fontWeight: FontWeight.w400,
              color: colorScheme.textPrimary,
            ),
          ),
        ),
        if (widget.bottomHintText.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              widget.bottomHintText,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: widget.bottomHintColor ?? colorScheme.textPrimary,
              ),
            ),
          ),
        if (_errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              _errorText!,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorPath.redOrange,
              ),
            ),
          ),
      ],
    );
  }
}
