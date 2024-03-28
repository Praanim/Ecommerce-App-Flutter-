import 'package:nattt_bazaar/core/constants/button_style_constants.dart';
import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/routes/route_constants.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:nattt_bazaar/core/utils/gap.dart';
import 'package:nattt_bazaar/core/widgets/custom_elevated_button.dart';
import 'package:nattt_bazaar/features/auth/presentation/providers/auth_providers.dart';
import 'package:nattt_bazaar/features/auth/presentation/providers/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LogOutBottomSheetWidget extends ConsumerWidget {
  const LogOutBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      authNotifierProvider,
      (previous, next) {
        if (next is AuthSignOut) {
          ref.read(userDataProvider.notifier).clearUpUserDetails();
          context.goNamed(RouteConstants.loginScreen);
        } else if (next is AuthFailure) {
          context.pop();
          context.showSnackBar(
              message: "Please try again later.", toastType: ToastType.error);
        }
      },
    );
    return Padding(
      padding: const EdgeInsets.all(ValConstants.value24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Logout",
            style: context.appTextTheme.headlineSmall,
          ),
          VerticalGap.xl,
          Text(
            'Are you sure you want to logout?',
            style: context.appTextTheme.titleMedium,
          ),
          VerticalGap.s,
          SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
              onPressed: () {
                //do logout Action
                ref.read(authNotifierProvider.notifier).signOut();
              },
              title: 'Yes',
              titleStyle: context.appTextTheme.displayMedium!
                  .copyWith(color: context.appColorScheme.primary),
              btnStyle: CustomBtnStyle.secondaryBtnStyle(context),
            ),
          ),
          VerticalGap.s,
          SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
              onPressed: () {
                //pop the screen
                context.pop();
              },
              title: 'No',
            ),
          ),
          VerticalGap.s,
        ],
      ),
    );
  }
}
