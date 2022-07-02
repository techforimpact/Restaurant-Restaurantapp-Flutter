import 'package:get/get.dart';

import 'state.dart';

class AllProductsLogic extends GetxController {
  final state = AllProductsState();
  int? tabIndex = 0;
  updateTabIndex(int? newValue) {
    tabIndex = newValue;
    update();
  }
}
