import 'package:carousel_slider/carousel_slider.dart';
import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:nattt_bazaar/core/widgets/image_container.dart';
import 'package:nattt_bazaar/features/home/presentation/providers/carousel_count_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomCarouselSlider extends StatelessWidget {
  CustomCarouselSlider({super.key});

  final List<String> imageList = [
    ImageConstants.carousel1,
    ImageConstants.carousel2,
    ImageConstants.carousel3
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
                      image: AssetImage(item),
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
