import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/themes/app_colors.dart';
import '../../products/domain/entities/products_base_entity.dart';

class CartsCardProductsWidget extends StatelessWidget {
  const CartsCardProductsWidget({
    super.key,
    this.entity,
    this.onTapDecrement,
    this.onTapIncrement,
  });

  final ProductsEntity? entity;
  final void Function()? onTapDecrement;
  final void Function()? onTapIncrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: 60,
      padding: const EdgeInsets.only(left: 12, right: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              width: 60,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
                image: entity?.imageUrl != ''
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("${entity?.imageUrl}"),
                      )
                    : null,
              ),
              child: entity?.imageUrl == ''
                  ? Icon(
                      Icons.photo,
                      size: 24.0,
                      color: Colors.grey[400],
                    )
                  : null,
            ),
          ),
          12.width,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                '${entity?.name}'.asSubtitleNormal(
                  fontWeight: FontWeight.w400,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                        ),
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
                    Container(
                      height: 30,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(-2, -3),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: onTapDecrement,
                            child: const Icon(
                              Icons.remove,
                              size: 16.0,
                            ),
                          ),
                          VerticalDivider(color: Colors.grey.shade100),
                          4.width,
                          Obx(
                            () => '${entity?.quantity.value}'
                                .asSubtitleNormal(fontWeight: FontWeight.w400),
                          ),
                          4.width,
                          VerticalDivider(color: Colors.grey.shade100),
                          InkWell(
                            onTap: onTapIncrement,
                            child: const Icon(
                              Icons.add,
                              size: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
