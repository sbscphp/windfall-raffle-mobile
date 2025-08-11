import 'package:flutter/material.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

class RowDescriptionItem extends StatelessWidget {
  final String? description;
  final Widget item;
  const RowDescriptionItem({
    super.key,
    this.description,
    this.item = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          description ?? "",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.textSecondary,
          ),
        ),
        Flexible(child: item),
      ],
    );
  }
}