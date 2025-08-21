import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

import '../../core/constants/color_path.dart';


class CustomExpansionTile extends StatefulWidget {
  final Widget primaryChild;
  final Widget secondaryChild;
  final bool? initiallyExpanded;

  const CustomExpansionTile({
    super.key,
    required this.primaryChild,
    required this.secondaryChild,
    this.initiallyExpanded = false,
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>{
  bool _isExpanded = false;

  @override
  void initState() {
    _isExpanded = widget.initiallyExpanded!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WindfallContainer(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h
      ),
      child: Column(
        children: <Widget>[
          Clickable(
            onPressed: (){
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Row(
              children: [
                Expanded(
                  child: widget.primaryChild,
                ),
                SizedBox(width: 20.w,),
                Icon(_isExpanded ?Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, size: 30, color: Theme.of(context).colorScheme.text5,)
              ],
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: widget.secondaryChild,
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}