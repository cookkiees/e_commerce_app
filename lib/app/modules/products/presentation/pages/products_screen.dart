import 'dart:io';

import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/app_shimmer_loading_products_widget.dart';
import '../../../../config/routers/app_routes.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../extensions/menu_category_extension.dart';
import '../../../main/controllers/main_controller.dart';
import '../../domain/entities/products_base_entity.dart';
import '../bloc/products_bloc.dart';
import '../widgets/products_card_widget.dart';

class ProductsScreen extends GetView<MainController> {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProductsBloc>(context);
    bloc.add(const ProductsGetInitialEvent());
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          mini: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: AppColors.primary,
          onPressed: () async {
            final result =
                await context.pushNamed(AppRoutes.productsCreate.name);
            if (result != null) {
              result as bool;
              if (result) {
                bloc.add(const ProductsGetRefreshEvent());
              }
            }
          },
          child: const Icon(
            Icons.add,
            size: 24.0,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: false,
        title: "PRODUCTS".asSubtitleBig(
          fontWeight: FontWeight.w400,
        ),
      ),
      body: NestedScrollView(headerSliverBuilder: (context, state) {
        return [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 40,
            expandedHeight: 40,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(left: 14, right: 12, top: 12),
                child: Obx(
                  () {
                    var selected = controller.selectedProducts.value;
                    return Wrap(
                      spacing: 12,
                      children: MenuCategory.values.asMap().entries.map((e) {
                        var index = e.key;
                        var catrgory = e.value;
                        return InkWell(
                          onTap: () {
                            controller.setselectedProducts(e.key);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: selected == index
                                    ? const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(2, -3),
                                          blurRadius: 5,
                                        )
                                      ]
                                    : null),
                            child: Text(
                              catrgory.name,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: selected == index
                                    ? AppColors.primary
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
          )
        ];
      }, body: Obx(() {
        final index = controller.selectedProducts.value;
        return RefreshIndicator.adaptive(
          displacement: 10,
          backgroundColor: AppColors.primary,
          color: Platform.isIOS ? Colors.black : Colors.white,
          onRefresh: () async {
            bloc.add(const ProductsGetRefreshEvent());
          },
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              switch (state) {
                case ProductsLoadingState():
                  return const AppShimmerLoadingProductsWidget();
                case ProductsFailureState():
                  return Text("${state.failure}");
                case ProductsErrorState():
                  if (state.error ==
                      "Exception: type 'Null' is not a subtype of type 'Map<String, dynamic>'") {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              setCategoryIcon(index),
                              size: 24.0,
                              color: Colors.grey,
                            ),
                            8.height,
                            "your product is not yet available, tap the plus button below to create a new product !"
                                .asSubtitleNormal(
                              color: Colors.grey,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Text("${state.error}");
                case ProductsGetSuccessState():
                  List<ProductsEntity>? results =
                      filteredProducts(state.entity, index);
                  if (results?.isEmpty ?? true) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            setCategoryIcon(index),
                            size: 24.0,
                            color: Colors.grey,
                          ),
                          8.height,
                          "You don't have products in this category !"
                              .asSubtitleNormal(color: Colors.grey),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: results?.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                          top: 24, bottom: kToolbarHeight + 40),
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ProductsCardWidget(
                            entity: results?[index],
                          ),
                        );
                      },
                    );
                  }

                default:
                  return Text("${state.error}");
              }
            },
          ),
        );
      })),
    );
  }

  IconData setCategoryIcon(int index) {
    switch (index) {
      case 0:
        return Icons.rice_bowl_outlined;
      case 1:
        return Icons.local_cafe_outlined;
      case 2:
        return Icons.bubble_chart_outlined;
      case 3:
        return Icons.icecream_outlined;
      default:
        return Icons.person_outline;
    }
  }

  filteredProducts(ListProductsEntity? data, int index) {
    if (data != null) {
      return data.products!.where((product) {
        return product.category == MenuCategory.values[index].name;
      }).toList();
    }
  }
}
