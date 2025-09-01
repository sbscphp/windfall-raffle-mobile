import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  ImageProvider? _imageProvider;


  @override
  void initState() {
    super.initState();
    if (_hasImage(widget.image)) {
      _imageProvider = CachedNetworkImageProvider(widget.image!);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_imageProvider != null) {
      precacheImage(_imageProvider!, context);
    }
  }

  @override
  void didUpdateWidget(covariant DisplayImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.image != widget.image && _hasImage(widget.image)) {
      setState(() {
        _imageProvider = CachedNetworkImageProvider(widget.image!);
      });
      precacheImage(_imageProvider!, context);
    } else if (!_hasImage(widget.image)) {
      setState(() {
        _imageProvider = null;
      });
    }
  }

  bool _hasImage(String? url) {
    return url != null && url.trim().isNotEmpty;
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
        child: _imageProvider != null
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
