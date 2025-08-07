import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/utilities/debouncer.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';

import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';

class QuantityCounter extends StatefulWidget {
  final int lowerLimit, upperLimit, stepValue, value;
  final ValueChanged<dynamic> onChanged;
  final double? buttonSize;
  final double? buttonSpacing;
  final double? labelBgWidth;
  final double? labelSize;
  const QuantityCounter({
    super.key,
    this.value = 1,
    required this.onChanged,
    this.lowerLimit = 1,
    this.upperLimit = 1000000,
    this.stepValue = 1,
    this.buttonSize,
    this.buttonSpacing,
    this.labelBgWidth,
    this.labelSize
  });

  @override
  State<QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<QuantityCounter> {

  final _quantity = TextEditingController();
  final _fn = FocusNode();
  late Debouncer debouncer;

  @override
  void initState() {
    _quantity.text = widget.value.toString();
    debouncer = Debouncer(milliseconds: 400);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant QuantityCounter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != int.tryParse(_quantity.text)) {
      _quantity.text = widget.value.toString();
    }
  }

  @override
  void dispose() {
    _fn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Clickable(
          onPressed: (){
            _fn.unfocus();
            if(int.tryParse(_quantity.text) == widget.lowerLimit){
              return;
            }

            setState(() {
              _quantity.text = ((int.tryParse(_quantity.text) ?? 0) - widget.stepValue).toString();
              widget.onChanged(int.tryParse(_quantity.text));
            });

          },
          child: Opacity(
            opacity: int.tryParse(_quantity.text) == widget.lowerLimit ? 0.3 : 1,
            child: Container(
              height: widget.buttonSize?.h ?? 40.h,
              width: widget.buttonSize?.w ??40.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.whiteText,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ColorPath.whisperGrey.withAlpha((255 * 0.1).toInt()),
                    spreadRadius: 0,
                    blurRadius: 22.86,
                    offset: const Offset(0, 2.86),
                    //spreadRadius: -12, // Spread radius
                    //blurRadius: 64, // Blur radius
                    //offset: const Offset(0, 32),
                  ),
                ],
              ),
              child: Center(
                child: CustomSvg(
                  asset:AppAsset.subtract,
                  height: 17.14.h,
                  width: 17.14.w,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: widget.buttonSpacing?.w ?? 21.w,),
        Container(
          width: widget.labelBgWidth?.w ?? 67.w,
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
          ),
          color: ColorPath.chablisPink,
          child:  Center(
            child: Text(
             _quantity.text,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: widget.labelSize?.sp,
                fontWeight: FontWeight.w800,
                color: ColorPath.redOrange,
              ),
            ),
          ),
        ),
        // Container(
        //   width: widget.labelBgWidth?.w ?? 67.w,
        //   height: 40.h,
        //   decoration: BoxDecoration(
        //     color: ColorPath.chablisPink,
        //   ),
        //   child: Center(
        //     child: TextFormField(
        //       showCursor: false,
        //       controller: _quantity,
        //       focusNode: _fn,
        //       textAlign: TextAlign.center,
        //       textAlignVertical: TextAlignVertical.center,
        //       style: Theme.of(context).textTheme.titleMedium?.copyWith(
        //         fontSize: widget.labelSize?.sp,
        //         fontWeight: FontWeight.w800,
        //         color: ColorPath.redOrange,
        //       ),
        //       keyboardType: TextInputType.number,
        //       decoration: const InputDecoration(
        //         border: InputBorder.none,
        //         isDense: true,
        //         contentPadding: EdgeInsets.zero,
        //       ),
        //       onChanged: (value){
        //
        //         debouncer.performAction(action: () async {
        //           setState(() {
        //             if(_quantity.text.isEmpty)_quantity.text = '1';
        //           });
        //           widget.onChanged(int.tryParse(_quantity.text));
        //         });
        //
        //       },
        //       onFieldSubmitted: (newValue) {
        //
        //       },
        //     ),
        //   ),
        // ),
        SizedBox(width: widget.buttonSpacing?.w ?? 21.w,),
        Clickable(
          onPressed: (){
            _fn.unfocus();
            if(int.tryParse(_quantity.text) == widget.upperLimit){
              return;
            }
            setState(() {
              _quantity.text = ((int.tryParse(_quantity.text) ?? 0) + widget.stepValue).toString();
            });
            widget.onChanged(int.tryParse(_quantity.text));
          },
          child: Opacity(
            opacity: int.tryParse(_quantity.text) == widget.upperLimit ? 0.3 : 1,
            child: Container(
              height: widget.buttonSize?.h ?? 40.h,
              width: widget.buttonSize?.w ??40.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.whiteText,
                boxShadow: [
                  BoxShadow(
                    color: ColorPath.whisperGrey.withAlpha((255 * 0.1).toInt()),
                    spreadRadius: 0,
                    blurRadius: 22.86,
                    offset: const Offset(0, 2.86),
                    //spreadRadius: -12, // Spread radius
                    //blurRadius: 64, // Blur radius
                    //offset: const Offset(0, 32),
                  ),
                ],
              ),
              child: Center(
                child: CustomSvg(
                  asset:AppAsset.add,
                  height: 17.14.h,
                  width: 17.14.w,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
