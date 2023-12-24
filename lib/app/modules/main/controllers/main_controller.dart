import 'package:get/get.dart';

class MainController extends GetxController {
  final RxBool isSelectedSearch = false.obs;

  final RxBool isHideBottomNav = true.obs;

  void setHideBottomNav(bool value) {
    isHideBottomNav.value = value;
  }

  RxInt railNavIndex = 0.obs;

  void setRailNavIndex(int value) {
    railNavIndex.value = value;
  }

  RxInt menuIndex = 0.obs;

  void setMenuIndex(int value) {
    menuIndex.value = value;
  }

  RxInt storeIndex = 0.obs;

  void setStoreIndex(int value) {
    storeIndex.value = value;
  }

  RxInt selectedProducts = 0.obs;
  void setselectedProducts(int value) {
    selectedProducts.value = value;
  }

  RxInt selectedActivity = 0.obs;
  void setSelectedActivity(int value) {
    selectedActivity.value = value;
  }

  RxInt selectedCustomers = 0.obs;
  void setSelectedCustomers(int value) {
    selectedCustomers.value = value;
  }
}
