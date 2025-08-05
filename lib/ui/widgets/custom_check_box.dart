import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

import '../../core/constants/app_asset.dart';
import 'clickable.dart';
import 'custom_svg.dart';


class CustomCheckBox extends StatefulWidget {
  final double? height;
  final double? width;
  final ValueChanged<bool> onchanged;
  const CustomCheckBox({super.key, this.height, this.width, required this.onchanged});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _active = false;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Clickable(
      onPressed: (){
        setState(() {
          _active = !_active;
        });
        widget.onchanged(_active);
      },
      child: Container(
        height: 20.h,
        width: 20.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: _active ? colorScheme.brandColor:colorScheme.textFieldBorder
          ),
          borderRadius: BorderRadius.all(Radius.circular(6.r))
        ),
        child: _active ? Center(
          child: CustomSvg(asset: AppAsset.checkMark, height: 6.42.h, width: 9.33.w,),
        ):const SizedBox(),
      ),
    );
  }
}
