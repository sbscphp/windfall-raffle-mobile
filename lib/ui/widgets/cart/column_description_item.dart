import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

class ColumnDescriptionItem extends StatelessWidget {
  final String? description;
  final Widget item;
  final CrossAxisAlignment crossAxisAlignment;

  const ColumnDescriptionItem({
    super.key,
    this.description,
    this.item = const SizedBox.shrink(),
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          description ?? "",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.textSecondary,
          ),
        ),
        SizedBox(height: 6.h),
        item,
      ],
    );
  }
}