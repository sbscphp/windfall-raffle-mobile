import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/ui/widgets/custom_divider.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';
import '../../../core/constants/color_path.dart';
import '../clickable.dart';

class GameDetailsSection extends StatefulWidget {
  final EdgeInsets? margin;
  final String title;
  final String value;
  const GameDetailsSection({super.key, required this.title, required this.value, this.margin});

  @override
  State<GameDetailsSection> createState() => _GameDetailsSectionState();
}

class _GameDetailsSectionState extends State<GameDetailsSection> {

  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    return WindfallContainer(
      padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w
      ),
      margin: widget.margin,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary),
                textAlign: TextAlign.center,
              ),
              Clickable(
                onPressed: (){
                  setState(() {
                    _showMore = !_showMore;
                  });
                },
                child:  !_showMore ?
                Row(
                  children: [
                    Text(
                      'Show More',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorPath.hazeGreen),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 4.w,),
                    Icon(Icons.keyboard_arrow_down, size: 12, color: ColorPath.hazeGreen,)
                  ],
                )
                    :Row(
                  children: [
                    Text(
                      'Show Less',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorPath.redOrange),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 4.w,),
                    Icon(Icons.keyboard_arrow_up, size: 12, color: ColorPath.redOrange,)
                  ],
                ),)
            ],
          ),
          CustomDivider(
            color: ColorPath.athensGrey,
            equalVerticalSpace: false,
            verticalSpace: 8,
            bottomMargin: 16,
          ),
          Container(
            constraints: _showMore
                ? const BoxConstraints() // full height
                : const BoxConstraints(maxHeight: 50),
            child: Html(
              data: widget.value,
              style: {
                "*": Style(
                  fontSize: FontSize(12.sp),
                  color: Theme.of(context).colorScheme.textTertiary,
                  lineHeight: LineHeight.number(1.2.h),
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                ),
              },
            ),
          )
          // Text(
          //   widget.value,
          //   style: Theme.of(context)
          //       .textTheme
          //       .bodySmall
          //       ?.copyWith(
          //       fontWeight: FontWeight.w400,
          //       color: Theme.of(context).colorScheme.textTertiary),
          //   maxLines: _showMore ? null : 2,
          //   overflow: _showMore ? TextOverflow.visible : TextOverflow.ellipsis,
          //   //overflow: TextOverflow.ellipsis,
          // ),

        ],
      ),
    );
  }
}
