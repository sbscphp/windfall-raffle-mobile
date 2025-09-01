import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/data/view_models/bottom_nav_view_model.dart';
import 'package:windfall/ui/widgets/clickable.dart';

import '../../../core/constants/color_path.dart';
import '../../../core/data/view_models/profile_vms/profile_vm.dart';
import '../../../core/utilities/utilities.dart';

class InAppDisplayImage extends StatelessWidget {
  final String tag;
  const InAppDisplayImage({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child){
        final profileVm = ref.watch(profileViewModel);
        final image = profileVm.image;
        final hasImage = image.isNotEmpty;
        final firstName = profileVm.firstname;
        final lastName = profileVm.lastname;
        return Clickable(
          onPressed: (){
            final container =
            ProviderScope.containerOf(context);
            final vm =
            container.read(bottomNavViewModel);
            vm.updateIndex(3);
          },
          child: Hero(
            tag: tag,
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorPath.redOrange
              ),
              child: Container(
                padding: EdgeInsets.all(1.w),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                ),
                child: hasImage ? Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundColor: ColorPath.athensGrey,
                    radius: 40.r,
                    child: CachedNetworkImage(
                      imageUrl: image,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                        radius: 40.r,
                      ),
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) => Center(
                        child: userInitials(firstName, lastName, context)
                      ), // Or any widget for errors
                    ),
                  ),

                )
                    :Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundColor: ColorPath.fairPink,
                    radius: 40.r,
                    child: Center(
                      child: userInitials(firstName, lastName, context),
                    ),
                  ),

                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget userInitials(String firstname, String lastname, BuildContext context){
    return Text(
      Utilities.getNameInitials(firstName: firstname, lastName: lastname),
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: ColorPath.redOrange
      ),
    );
  }
}
