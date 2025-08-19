import 'package:flutter/material.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

class RowDescriptionItem extends StatelessWidget {
  final String? description;
  final Widget item;
  final CrossAxisAlignment crossAxisAlignment;
  final Color? descriptionColor;
  final double? fontSize;
  const RowDescriptionItem({
    super.key,
    this.description,
    this.descriptionColor,
    this.fontSize,
    this.item = const SizedBox.shrink(),
    this.crossAxisAlignment = CrossAxisAlignment.start
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          description ?? "",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: fontSize,
            color: descriptionColor ?? Theme.of(context).colorScheme.textSecondary,
          ),
        ),
        Flexible(child: item),
      ],
    );
  }
}