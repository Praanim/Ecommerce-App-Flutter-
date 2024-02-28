import 'package:flutter_riverpod/flutter_riverpod.dart';

///This provider provides the number of the cart items for the user.
final cartItemsCountProvider = StateProvider<int>((ref) => 0);
