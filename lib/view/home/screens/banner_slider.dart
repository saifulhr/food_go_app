import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_go_app/controller/banner_controller.dart';
import 'package:get/get.dart';

class BannerSlider extends GetView<BannerController> {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BannerController());

    return Obx(() {
      final banners = controller.bannerList;

      if (controller.isBannerLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (banners.isEmpty) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "No banners available",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }

      if (banners.length == 1) {
        return _buildBannerItem(banners.first);
      }

      return Column(
        children: [
          CarouselSlider.builder(
            itemCount: banners.length,
            itemBuilder: (context, index, realIdx) {
              final banner = banners[index];
              return _buildBannerItem(banner);
            },
            options: CarouselOptions(
              height: 180,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              onPageChanged: (index, reason) {
                controller.currentIndex.value = index;
              },
            ),
          ),
          SizedBox(
            height: 20,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  banners.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: controller.currentIndex.value == index ? 12 : 8,
                    height: controller.currentIndex.value == index ? 12 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.currentIndex.value == index
                          ? Colors.red
                          : Colors.grey[400],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildBannerItem(banner) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          banner.imageUrl ?? '',
          fit: BoxFit.cover,
          width: double.infinity,
          height: 140,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
