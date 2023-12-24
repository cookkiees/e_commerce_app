import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../domain/entities/products_base_entity.dart';

class ProductsCardWidget extends StatelessWidget {
  const ProductsCardWidget({super.key, this.entity, this.onDelete});

  final ProductsEntity? entity;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: 90,
      padding: const EdgeInsets.only(left: 12, right: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  width: 86,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                    image: entity?.imageUrl != ''
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('${entity?.imageUrl}'),
                          )
                        : null,
                  ),
                  child: entity?.imageUrl == ''
                      ? Icon(
                          setCategoryIcon(entity),
                          size: 50.0,
                          color: AppColors.primary.withOpacity(0.8),
                        )
                      : null,
                ),
              ),
              Container(
                height: 20,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(4),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(2, 3),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  setCategoryIcon(entity),
                  size: 16.0,
                  color: AppColors.primary.withOpacity(0.8),
                ),
              ),
            ],
          ),
          16.width,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                '${entity?.name}'.asSubtitleNormal(
                  fontWeight: FontWeight.w400,
                ),
                '${entity?.description}${entity?.description}'.asSubtitleSmall(
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  color: Colors.grey,
                ),
                4.height,
                Flexible(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(4),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(2, -3),
                                blurRadius: 5,
                              )
                            ],
                          ),
                          child: 'Rp${entity?.salePrice}'.asSubtitleSmall(
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              InkWell(
                onTap: onDelete,
                child: Container(
                  height: 30,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(-2, 3),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.delete,
                    size: 14,
                    color: AppColors.primary.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

IconData setCategoryIcon(ProductsEntity? entity) {
  switch (entity!.category) {
    case 'FOOD':
      return Icons.rice_bowl_outlined;
    case 'DRINKS':
      return Icons.local_cafe_outlined;
    case 'SNACKS':
      return Icons.bubble_chart_outlined;
    case 'ICE CREAM':
      return Icons.icecream_outlined;
    default:
      return Icons.person_outline;
  }
}
