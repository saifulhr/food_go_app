// import 'package:flutter/material.dart';
// import 'package:food_go_app/theme/all_images';
// import 'package:get/get.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

// class BottomNavController extends GetxController {
//   var page = 0.obs;
//   void changePage(int index) => page.value = index;
// }

// void main() {
//   runApp(GetMaterialApp(home: BottomNavScreen()));
// }

// class BottomNavScreen extends StatelessWidget {
//   final BottomNavController controller = Get.put(BottomNavController());

//   final List<Widget> pages = [
//     Center(child: Text('Home Screen')),
//     Center(child: Text('Search Screen')),
//     Center(child: Text('Add Screen')),
//     Center(child: Text('Chat Screen')),
//     Center(child: Text('Love Screen')),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(() => pages[controller.page.value]),
//       bottomNavigationBar: Obx(() => CurvedNavigationBar(
//             index: controller.page.value,
//             backgroundColor: Colors.transparent,
//             color: Colors.red,
//             height: 70,
//             items: [
//               CurvedNavigationBarItem(child: Image.asset(AllImages.homeIcon,height: 13,width: 15,), label: 'Home'),
//               CurvedNavigationBarItem(child: Icon(Icons.search), label: 'Search'),
//               CurvedNavigationBarItem(child: Icon(Icons.add), label: 'Add'),
//               CurvedNavigationBarItem(child: Icon(Icons.chat), label: 'Chat'),
//               CurvedNavigationBarItem(child: Icon(Icons.favorite), label: 'Love'),
//             ],
//             onTap: controller.changePage,
//           )),
//     );
//   }
// }
