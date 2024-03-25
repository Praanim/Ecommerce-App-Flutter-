import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:flutter/material.dart';

class ProfileCommonRow extends StatelessWidget {
  const ProfileCommonRow({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;

  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppConstants.pad6),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    title,
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    value,
                  ))
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
