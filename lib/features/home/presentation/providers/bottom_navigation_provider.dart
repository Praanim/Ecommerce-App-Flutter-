
import 'package:flutter_riverpod/flutter_riverpod.dart';


final currentPageNotifierProvider = StateNotifierProvider<CurrentPageNotifier,int>((ref) => CurrentPageNotifier());

class CurrentPageNotifier extends StateNotifier<int>{
  CurrentPageNotifier():super(0);

  void setIndex(int value){
    state = value;
  }
}