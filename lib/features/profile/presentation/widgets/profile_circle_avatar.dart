import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nattt_bazaar/features/auth/presentation/providers/auth_providers.dart';

// import '../../../../core/shared/image_picker_notifier.dart';

class ProfileCircleAvatar extends ConsumerWidget {
  const ProfileCircleAvatar({super.key});

  final double circleAvatarRadius = 50;

  final double positionedValue = -8;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final file = ref.watch(imagePickerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ValConstants.value16),
      child: Stack(
        children: [
          CircleAvatar(
              radius: circleAvatarRadius,
              backgroundColor: context.appColorScheme.tertiary,
              backgroundImage: const AssetImage(ImageConstants.appLogo)
              // file != null ? FileImage(file) : null,
              //  AssetImage(ImageConstants.carousel1),
              ),
          // Positioned(
          //   right: positionedValue,
          //   bottom: positionedValue,
          //   child: file == null
          //       ? IconButton(
          //           icon: _customIcon(context, Icons.add_a_photo_rounded),
          //           onPressed: () async {
          //             //pick image from gallery
          //             ref
          //                 .read(imagePickerProvider.notifier)
          //                 .pickImageFromGallery();
          //           },
          //         )
          //       : IconButton(
          //           onPressed: () {
          //             //save the image to the db & reset the state
          //             ref.read(userDataProvider)
          //             ref.read(imagePickerProvider.notifier).resetState();
          //           },
          //           icon: _customIcon(context, Icons.done,
          //               size: ValConstants.value30)),
          // ),
        ],
      ),
    );
  }

  // Icon _customIcon(BuildContext context, IconData iconData, {double? size}) {
  //   return Icon(
  //     iconData,
  //     color: context.appColorScheme.primary,
  //     size: size ?? ValConstants.value24,
  //   );
  // }
}
