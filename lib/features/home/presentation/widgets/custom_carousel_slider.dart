import 'package:carousel_slider/carousel_slider.dart';
import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/core/widgets/image_container.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/carousel_count_provider.dart';
import 'package:eccomerce_frontend/features/product/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomCarouselSlider extends StatelessWidget {
  CustomCarouselSlider({super.key});

  List<String> imageList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  ];
  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Stack(
        children: [
          CarouselSlider(
            items: imageList
                .map((item) => ImageContainer(
                      imageUrl: item,
                    ))
                .toList(),
            carouselController: carouselController,
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              aspectRatio: 0.9,
              autoPlay: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                //assigning the provider
                ref.read(carouselImageProvider.notifier).changeIndex(index);
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageList.map((carouselImage) {
                final currentIndex = ref.watch(carouselImageProvider);
                return Container(
                  height: 10,
                  margin:
                      const EdgeInsets.symmetric(horizontal: AppConstants.pad2),
                  width: carouselImage == imageList[currentIndex]
                      ? ValConstants.value24
                      : ValConstants.value12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ValConstants.value8),
                    color: carouselImage == imageList[currentIndex]
                        ? context.appColorScheme.primary
                        : context.appColorScheme.background,
                  ),
                );
              }).toList(),
            ),
          )
        ],
      );
    });
  }
}
