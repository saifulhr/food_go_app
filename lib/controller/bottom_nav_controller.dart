import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var page = 0.obs;

  void changePage(int index) {
    print("Page changed to $index");  // Debug print
    page.value = index;
  }
}
