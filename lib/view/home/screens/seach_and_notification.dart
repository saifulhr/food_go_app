import 'package:flutter/material.dart';
import 'package:food_go_app/theme/all_images.dart';

class SearchAndNotification extends StatelessWidget {
  const SearchAndNotification({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(2, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Image.asset(
                  AllImages.searchIcon,
                  width: 18,
                  height: 18,
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Image.asset(AllImages.dropIcon, height: 50, width: 50),
      ],
    );
  }
}