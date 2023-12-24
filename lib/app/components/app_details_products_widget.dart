import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';

import '../config/themes/app_colors.dart';
import '../modules/products/domain/entities/products_base_entity.dart';
import '../modules/products/presentation/widgets/products_card_widget.dart';

class AppDetailProductWidget extends StatelessWidget {
  const AppDetailProductWidget({
    super.key,
    required this.results,
  });

  final ProductsEntity? results;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.only(left: 16, right: 16, bottom: kToolbarHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${results?.imageUrl}'),
                ),
              ),
            ),
          ),
          16.height,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  '${results?.name}'.toUpperCase().asSubtitleBig(),
                  12.width,
                  Icon(
                    setCategoryIcon(results),
                    size: 16.0,
                    color: AppColors.primary,
                  ),
                ],
              ),
              12.height,
              Row(
                children: [
                  Container(
                    height: 20,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColors.primary,
                      ),
                    ),
                    child: '${results?.category}'.asSubtitleSmall(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              12.height,
              Row(
                children: [
                  Container(
                    height: 20,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColors.primary,
                      ),
                    ),
                    child: 'Rp${results?.basicPrice}'.asSubtitleSmall(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  12.width,
                  Container(
                    height: 20,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColors.primary,
                      ),
                    ),
                    child: 'Rp${results?.salePrice}'.asSubtitleSmall(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          '${results?.description}'.asSubtitleSmall(
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
