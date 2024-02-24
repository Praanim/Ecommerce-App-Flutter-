import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  ///the error message to be shown
  final String errorMssg;

  const CustomErrorWidget({super.key, required this.errorMssg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMssg),
    );
  }
}
