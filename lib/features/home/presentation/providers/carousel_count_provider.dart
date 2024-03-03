import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarouselImage {
  final int id;
  final String imageUrl;

  CarouselImage({required this.id, required this.imageUrl});
}

final carouselImageProvider = StateNotifierProvider<CarouselImageNotifier, int>(
    (ref) => CarouselImageNotifier());

class CarouselImageNotifier extends StateNotifier<int> {
  CarouselImageNotifier() : super(0);

  void changeIndex(int index) {
    state = index;
  }
}
