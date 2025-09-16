import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/ui/widgets/clickable.dart';

class CustomRadioButton extends StatefulWidget {
  final ValueChanged<bool>? onchanged;
  bool value;
  final Color? borderColor;
  final double? size;
  final bool? disableClick;
  CustomRadioButton({super.key, this.size = 16, this.disableClick = false, this.onchanged, this.value = false, this.borderColor});

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {

  double innerSize = 6;

  @override
  void initState() {
    if(widget.size != null && (widget.size != 0 && widget.size! > innerSize)){
      innerSize = widget.size! - 10;
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final isClickDisabled = widget.disableClick ?? false;
    return Clickable(
      onPressed: isClickDisabled ? null : (){
        setState(() {
          widget.value = !widget.value;
        });
        if(widget.onchanged != null){
          widget.onchanged!(widget.value);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: widget.size?.h ?? 15.h,
        width: widget.size?.w ?? 15.w,
        decoration: BoxDecoration(
          color: widget.value ? ColorPath.magnoliaPurple:Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.value ? ColorPath.redOrange
                :ColorPath.mischkaGrey,
          )
        ),
        child: Center(
          child: widget.value ? AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: innerSize.h,
            width: innerSize.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPath.redOrange

            ),
          ):const SizedBox(),
        ),
      ),
    );
  }
}
