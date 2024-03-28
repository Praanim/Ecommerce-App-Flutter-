import 'package:flutter/material.dart';
import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/widgets/no_content_widget.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppConstants.pad16),
        child: NoContentWidget(
          text: "No Internet Connection Available!!!",
          imageUrl: ImageConstants.noInternetImage,
        ),
      ),
    );
  }
}
