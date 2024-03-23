import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/constants/text_constants.dart';
import 'package:eccomerce_frontend/core/shared/custom_app_bar.dart';
import 'package:eccomerce_frontend/core/utils/gap.dart';
import 'package:eccomerce_frontend/features/auth/data/models/user.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/auth_providers.dart';
import 'package:eccomerce_frontend/features/profile/presentation/widgets/profile_common_header.dart';
import 'package:eccomerce_frontend/features/profile/presentation/widgets/profile_common_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAccountDetails extends StatelessWidget {
  const UserAccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.pad16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileCommonHeader(
                text: "Account Details", icon: IconConstants.personIcon),
            VerticalGap.l,
            Consumer(builder: (context, ref, child) {
              final UserModel userDetails = ref.watch(userDataProvider)!;
              return Column(
                children: [
                  ProfileCommonRow(
                    title: "Full Name",
                    value: userDetails.fullName!,
                  ),
                  ProfileCommonRow(
                      title: "Email Address", value: userDetails.email!),
                  if (userDetails.mobile != null)
                    ProfileCommonRow(
                        title: "Phone Number",
                        value:
                            '${TextConstants.countryCode}${userDetails.mobile!}')
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
