import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/shared/image_picker_notifier.dart';

class ProfileCircleAvatar extends ConsumerWidget {
  const ProfileCircleAvatar({super.key});

  final double circleAvatarRadius = 50;

  final double positionedValue = -8;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final file = ref.watch(imagePickerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ValConstants.value16),
      child: Stack(
        children: [
          CircleAvatar(
            radius: circleAvatarRadius,
            backgroundColor: context.appColorScheme.tertiary,
            backgroundImage: file != null ? FileImage(file) : null,
            //  AssetImage(ImageConstants.carousel1),
          ),
          Positioned(
            right: positionedValue,
            bottom: positionedValue,
            child: IconButton(
              icon: Icon(
                Icons.add_a_photo_rounded,
                color: context.appColorScheme.primary,
                size: ValConstants.value24,
              ),
              onPressed: () async {
                //pick image from gallery
                ref.read(imagePickerProvider.notifier).pickImageFromGallery();
              },
            ),
          ),
        ],
      ),
    );
  }
}
