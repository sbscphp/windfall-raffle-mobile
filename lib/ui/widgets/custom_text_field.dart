import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';



class CustomTextField extends StatefulWidget {
  final String label;
  final double? labelSize;
  final FontWeight labelFontWeight;
  final Color? labelColor;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final double? textSize;
  final Color textColor;
  final bool obscure;
  final  Widget? suffixIcon;
  final  Widget? prefixIcon;
  final String hintText;
  final String bottomHintText;
  final double? hintSize;
  final Color? hintColor;
  final Color? bottomHintColor;
  final bool enabled;
  final bool readOnly;
  final bool isCompulsory;
  final FocusNode? focusPointer;
  final int maxLines;
  final bool isOtp;
  final bool showLabel;


  const CustomTextField(
      {super.key,
        this.showLabel = true,
        this.label = '',
        this.labelSize,
        this.labelFontWeight = FontWeight.w400,
        this.labelColor,
        this.controller,
        this.onChanged,
        this.validator,
        this.inputFormatters,
        this.keyboardType = TextInputType.text,
        this.textSize,
        this.textColor = Colors.black,
        this.obscure = false,
        this.suffixIcon,
        this.hintText = '',
        this.hintSize,
        this.hintColor,
        this.bottomHintColor,
        this.enabled = true,
        this.readOnly = false,
        this.prefixIcon,
        this.bottomHintText = '',
        this.isCompulsory = true,
        this.focusPointer,
        this.maxLines = 1,
        this.isOtp = false
      });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

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
                    fontWeight: widget.labelFontWeight),
              ),
              if (widget.isCompulsory)
                SizedBox(
                  width: 5.w,
                ),
              if (widget.isCompulsory)
                Text(
                  '*',
                  style: textTheme.bodyMedium?.copyWith(
                      color: ColorPath.redOrange,
                      fontSize: widget.labelSize,
                      fontWeight: FontWeight.w500),
                ),
            ],
          ),
        if (widget.showLabel)
          SizedBox(
            height: 6.h,
          ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: colorScheme.textFieldFillColor,
              borderRadius: BorderRadius.all(Radius.circular(8.r))
          ),
          child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              validator: (value) {
                // if(widget.validator != null){
                //   final error = widget.validator!(value);
                //   SchedulerBinding.instance.addPostFrameCallback((_) {
                //     setState(() {
                //       _errorText = error;
                //     });
                //   });
                // }
                // return null;

                if (widget.validator != null) {
                  final error = widget.validator!(value);

                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        _errorText = error;
                      });
                    }
                  });

                  return error == null ? null : '';
                }
                return null;
              },
              controller: widget.controller,
              obscureText: widget.obscure,
              textAlign: widget.isOtp ? TextAlign.center : TextAlign.start,
              style: widget.isOtp ? Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: widget.textSize?.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.brandColor,
                  letterSpacing: 24
              ):Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: widget.textSize?.sp,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.textPrimary,
              ),
              onChanged: widget.onChanged,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                errorText: null,
                errorMaxLines: 1,
                errorStyle: const TextStyle(height: 0, fontSize: 0),
                hintText: widget.hintText,
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textFieldHint
                ),
                suffixIcon: widget.suffixIcon,
                suffixIconConstraints: BoxConstraints(
                  minWidth: 16.w,
                  minHeight: 16.h,
                ),
                prefixIcon: widget.prefixIcon,
                prefixIconConstraints: BoxConstraints(
                  minWidth: 16.w,
                  minHeight: 16.h,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                contentPadding: EdgeInsets.only(left: 14.w, right: 14.w, top: 10.h, bottom: 10.h),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color:  _errorText != null ? ColorPath.redOrange: colorScheme.textFieldBorder, width: 1.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _errorText != null ? ColorPath.redOrange: colorScheme.textFieldBorder, width: 1.w),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: _errorText != null ? ColorPath.redOrange:colorScheme.textFieldBorder, width: 1.w)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: colorScheme.textFieldBorder, width: 0.5.w)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: _errorText != null ? ColorPath.redOrange:colorScheme.textFieldBorder, width: 1.w)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: _errorText != null ? ColorPath.redOrange:colorScheme.textFieldBorder, width: 1.w)),
              )),
        ),
        if(widget.bottomHintText.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              widget.bottomHintText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: widget.bottomHintColor ?? Theme.of(context).colorScheme.textFieldHint
              ),
            ),
          ),
        if(_errorText != null)Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Text(
            _errorText!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorPath.redOrange
            ),
          ),
        ),
      ],
    );

  }
}
