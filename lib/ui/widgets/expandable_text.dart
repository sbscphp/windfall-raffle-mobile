import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

import 'clickable.dart';


class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;
  final bool hasHeader;
  final String headerText;
  final double textSize;
  final VoidCallback? onPressed;

  const ExpandableText(
      {super.key,
      required this.text,
      this.trimLines = 3,
      this.textSize = 14,
      this.hasHeader = false,
        this.onPressed,
      this.headerText = ''});

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final span = TextSpan(text: widget.text);
    final tp = TextPainter(
      text: span,
      maxLines: widget.trimLines,
      textDirection: TextDirection.ltr,
    );

    tp.layout(maxWidth: MediaQuery.of(context).size.width - 32);

    bool isTextOverflowing = tp.didExceedMaxLines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.hasHeader)
          Column(
            children: [
              Text(
                widget.headerText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textPrimary),
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        Text(
          widget.text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.textPrimary
          ),
          maxLines:  _isExpanded ? 12 : widget.trimLines,
          overflow: TextOverflow.ellipsis,
        ),
        if (isTextOverflowing)
          Clickable(
            // onPressed: () {
            //   setState(() {
            //     _isExpanded = !_isExpanded;
            //   });
            // },
            onPressed: widget.onPressed,
            child: Text(
              // _isExpanded ? "View less" : "View more",
              'Learn More',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.textPrimary,
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).colorScheme.textPrimary
              ),
            ),
          ),
      ],
    );
  }
}
