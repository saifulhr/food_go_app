import 'dart:io';

import 'package:flutter/material.dart';

class ImagePickerSection extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onRemoveImage;
  final VoidCallback onImagePickTap;

  const ImagePickerSection({
    super.key,
    required this.imageFile,
    required this.onRemoveImage,
    required this.onImagePickTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImagePickTap,
      child: Stack(
        children: [
          Container(
            height: 190,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: imageFile != null
                  ? Image.file(imageFile!, fit: BoxFit.cover)
                  : Center(
                      child: Icon(
                        Icons.add,
                        size: 50,
                        color: Colors.grey[700],
                      ),
                    ),
            ),
          ),
          if (imageFile != null)
            Positioned(
              top: 6,
              right: 6,
              child: GestureDetector(
                onTap: onRemoveImage,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
