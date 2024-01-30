import 'package:eccomerce_frontend/features/home/domain/providers/product_provider.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/state/product_notifier.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/state/product_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, ProductState>(
  (ref) => ProductNotifier(
    productReposiotry: ref.watch(productRepositoryProvider),
  )..getAllProducts(),
);
