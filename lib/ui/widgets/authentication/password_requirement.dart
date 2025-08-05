import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import '../../../core/data/view_models/authentication_vms/password_vm.dart';

class PasswordRequirement extends ConsumerWidget {
  const PasswordRequirement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(passwordViewModel);
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.separated(
      itemCount: vm.results.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        final requirement = vm.pwdRequirements[index];
        final isVerified = vm.results[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Container(
              height: 3.h,
              width: 3.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: isVerified ? ColorPath.meadowGreen : colorScheme.pwdInactive, width: 1.w)
              ),
            ),
            SizedBox(width: 8.w,),
            Expanded(
              child:  Text(
                requirement,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isVerified ? ColorPath.meadowGreen : colorScheme.pwdInactive,
                ),
              ),
            )
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8.h,);
      },
    );
  }
}
