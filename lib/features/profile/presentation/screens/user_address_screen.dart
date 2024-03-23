import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/constants/text_constants.dart';
import 'package:eccomerce_frontend/core/routes/route_constants.dart';
import 'package:eccomerce_frontend/core/shared/custom_app_bar.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/core/utils/gap.dart';
import 'package:eccomerce_frontend/core/widgets/custom_elevated_button.dart';
import 'package:eccomerce_frontend/core/widgets/no_content_widget.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/auth_providers.dart';
import 'package:eccomerce_frontend/features/profile/presentation/widgets/profile_common_header.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.pad16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCommonHeader(
              icon: IconConstants.homeIcon,
              text: "Delivery Address",
            ),
            Expanded(child: _UserAddressContainer())
          ],
        ),
      ),
    );
  }
}

class _UserAddressContainer extends ConsumerWidget {
  const _UserAddressContainer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userDataProvider);
    final userAddress = userDetails?.address;

    if (userAddress?.address == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const NoContentWidget(text: "User Address Not Found"),
          VerticalGap.l,
          SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
                title: TextConstants.addAddressText,
                onPressed: () {
                  //add address page
                  context.goNamed(RouteConstants.addressDetailsScreen);
                }),
          )
        ],
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.pad16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Home/Work",
                style: context.appTextTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton.icon(
                  onPressed: () {
                    //edit the user address
                    context.goNamed(RouteConstants.addressDetailsScreen);
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: IconConstants.iconPrimarySize,
                  ),
                  label: const Text('Edit'))
            ],
          ),
          VerticalGap.m,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userAddress!.address!),
              Text(
                userAddress.city!,
              ),
              Text(userAddress.state!)
            ],
          )
        ],
      ),
    );
  }
}
