import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

import '../../core/constants/color_path.dart';
import '../../core/utilities/utilities.dart';

class DisplayImage extends StatefulWidget {
  final double size;
  final double borderWidth;
  final String? image;
  final Widget? errorWidget;
  final LinearGradient? linearGradient;
  final bool useGradient;
  final String firstName;
  final String lastName;
  final double? fontSize;
  final Color? borderColor;
  const DisplayImage({
    super.key,
    this.size = 40,
    this.borderWidth = 1,
    this.errorWidget,
    required this.image,
    this.useGradient = true,
    this.linearGradient,
    this.firstName = '',
    this.lastName = '',
    this.borderColor,
    this.fontSize
  });

  @override
  State<DisplayImage> createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {

  late ImageProvider _imageProvider;
  late bool _hasImage;

  @override
  void initState() {

    final isEmpty = widget.image?.isEmpty ?? true;
    _hasImage = widget.image != null && !isEmpty;

    if(_hasImage){
      _imageProvider = CachedNetworkImageProvider(widget.image ?? '',
        errorListener: (value) {
          toggle();
        },
      );
    }
    super.initState();
  }

  void toggle(){
    setState(() {
      _hasImage = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_hasImage){
      precacheImage(_imageProvider, context);
    }

  }


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(widget.borderWidth.w),
      decoration: BoxDecoration(
        color: widget.borderColor ?? Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Container(
        width: widget.size.w,
        height: widget.size.h,
        decoration: const BoxDecoration(
          color: ColorPath.fairPink,
          shape: BoxShape.circle,
        ),
        child: _hasImage
            ? CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: widget.size.r,
          backgroundImage: _imageProvider,
        ):Center(
          child: widget.errorWidget ?? Text(
            Utilities.getNameInitials(
                firstName: widget.firstName, lastName: widget.lastName),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: widget.fontSize,
                color: ColorPath.redOrange
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
