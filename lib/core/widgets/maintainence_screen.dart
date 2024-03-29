import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/shared/custom_app_bar.dart';
import 'package:nattt_bazaar/core/widgets/no_content_widget.dart';
import 'package:flutter/material.dart';

class MaintainenceScreen extends StatelessWidget {
  const MaintainenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
          // title: Text("Working"),
          ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.pad16),
        child: NoContentWidget(
            text:
                "We are working on this page.\nPlease, Be Patient!\nThank You!"),
      ),
    );
  }
}
