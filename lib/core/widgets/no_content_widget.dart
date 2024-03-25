import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:nattt_bazaar/core/utils/gap.dart';
import 'package:nattt_bazaar/features/auth/presentation/widgets/logo_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoContentWidget extends StatelessWidget {
  final String text;

  const NoContentWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const LogoImageWidget(assetUrl: ImageConstants.notFoundImage),
          VerticalGap.l,
          Text(
            text,
            style: context.appTextTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
