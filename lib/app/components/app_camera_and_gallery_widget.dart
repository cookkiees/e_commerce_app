import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../config/themes/app_colors.dart';

class AppCameraAndGalleryWidget extends StatelessWidget {
  const AppCameraAndGalleryWidget(
      {super.key, this.onTapCamera, this.onTapGallery});
  final void Function()? onTapCamera;
  final void Function()? onTapGallery;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              'Photo Product'.asSubtitleBig(
                fontWeight: FontWeight.w400,
              ),
              InkWell(
                onTap: () => context.pop(),
                child: const Icon(
                  Icons.clear,
                  size: 24.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          24.height,
          Row(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: onTapCamera,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(Icons.camera_alt,
                          size: 24.0, color: AppColors.primary),
                    ),
                  ),
                  4.height,
                  'Camera'.asSubtitleNormal(),
                ],
              ),
              16.width,
              Column(
                children: [
                  InkWell(
                    onTap: onTapGallery,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(Icons.photo,
                          size: 24.0, color: AppColors.primary),
                    ),
                  ),
                  4.height,
                  'Gallery'.asSubtitleNormal(),
                ],
              ),
            ],
          ),
          24.height,
        ],
      ),
    );
  }
}
