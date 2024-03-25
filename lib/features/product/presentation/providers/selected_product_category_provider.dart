import 'package:nattt_bazaar/features/home/presentation/providers/product_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedProductCategoryProvider =
    AutoDisposeNotifierProvider<SelectedProductCategoryNotifier, String>(
        () => SelectedProductCategoryNotifier());

class SelectedProductCategoryNotifier extends AutoDisposeNotifier<String> {
  SelectedProductCategoryNotifier();

  //initial state
  @override
  String build() {
    ref.onDispose(() {
      //below method gets all products.
      ref.read(productNotifierProvider.notifier).resetStateToProductSuccess();
    });
    return '';
  }

  //this variable stores the selected category.
  late String _selectedCategory = '';

  void selectCategory(String categoryId) {
    //the below condition will be true if the user has clicked already selected tag
    //in that case we un-select the selected tag.
    if (categoryId == _selectedCategory) {
      _selectedCategory = '';
      ref.read(productNotifierProvider.notifier).resetStateToProductSuccess();
      state = _selectedCategory;
      return;
    }
    _selectedCategory = categoryId;
    state = _selectedCategory;
  }
}
