import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';

import '../../core/data/enum/tag_type.dart';

class WindfallTag extends StatelessWidget {
  final TagType tag;
  const WindfallTag({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    switch (tag) {
      case TagType.instantGame:
        return Container(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: ColorPath.pattensBlue,
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _getTagText(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorPath.allPortBlue,
                ),
              ),
              SizedBox(width: 4.w),
              CustomSvg(asset: AppAsset.zap, width: 12.sp, height: 12.sp),
            ],
          ),
        );

      case TagType.success:
      case TagType.drawGame:
      case TagType.completed:
      case TagType.pending:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          margin: EdgeInsets.only(top: 4.h),
          decoration: BoxDecoration(
            color: tag == TagType.pending ? ColorPath.salomieBrown:ColorPath.foamGreen,
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (tag == TagType.completed)
                Row(
                  children: [
                    Icon(Icons.circle, color: ColorPath.meadowGreen, size: 10),
                    SizedBox(width: 8.w),
                  ],
                ),
              Center(
                child: Text(
                  _getTagText(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: tag == TagType.pending ? ColorPath.vesuviusBrown:ColorPath.meadowGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }

  String _getTagText() {
    switch (tag) {
      case TagType.instantGame:
        return "Instant Game";
      case TagType.success:
        return "Successful";
      case TagType.drawGame:
        return "Draw Game";
      case TagType.completed:
        return "Completed";
      case TagType.pending:
        return "Pending";
    }
  }
}
