import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:e_commerce_app/app/components/app_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

import '../../../components/app_empty_product_widget.dart';
import '../../../components/app_shimmer_loading_products_widget.dart';
import '../../../config/themes/app_colors.dart';
import '../../carts/controllers/carts_controllers.dart';
import '../../extensions/menu_category_extension.dart';
import '../../main/controllers/main_controller.dart';
import '../../products/domain/entities/products_base_entity.dart';
import '../../products/presentation/bloc/products_bloc.dart';
import '../widgets/sales_card_products_widget.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({
    super.key,
    this.onPressedPanelRight,
    this.onPressedPanelLeft,
  });

  final void Function()? onPressedPanelRight;
  final void Function()? onPressedPanelLeft;

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  var carts = Get.put(CartsController());
  var main = Get.put(MainController());
  final TextEditingController searchController = TextEditingController();
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProductsBloc>(context);
    bloc.add(const ProductsGetInitialEvent());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 1,
        elevation: 1,
        shadowColor: Colors.black38,
        title: Obx(
          () => main.isSelectedSearch.value
              ? SizedBox(
                  height: 40,
                  child: FadeInRight(
                    from: 40,
                    child: AppTextFormFieldWidget(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchTerm = value;
                        });
                      },
                      suffixIcon: InkWell(
                        onTap: () => main.isSelectedSearch.toggle(),
                        child: const Icon(
                          Icons.clear,
                          size: 22.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                )
              : Obx(
                  () => FadeIn(
                    child: MenuCategory.values[main.storeIndex.value].name
                        .asSubtitleBig(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
        ),
        actions: [
          InkWell(
            onTap: () => main.isSelectedSearch.toggle(),
            child: Obx(() {
              if (!main.isSelectedSearch.value) {
                return const Icon(
                  Icons.search_rounded,
                  size: 22.0,
                  color: AppColors.primary,
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ),
          Obx(() {
            if (!main.isSelectedSearch.value) {
              return 4.width;
            } else {
              return const SizedBox.shrink();
            }
          }),
          InkWell(
            onTap: widget.onPressedPanelRight,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  onPressed: widget.onPressedPanelRight,
                  icon: const Icon(
                    Icons.local_grocery_store_outlined,
                    size: 20.0,
                    color: AppColors.primary,
                  ),
                ),
                Obx(() {
                  if (carts.carts.isNotEmpty) {
                    return Positioned(
                      right: 8,
                      top: 6,
                      child: Badge(
                        smallSize: 32,
                        backgroundColor: Colors.red,
                        label: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: Text(
                            "${carts.carts.length}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                })
              ],
            ),
          ),
        ],
        leading: IconButton(
          onPressed: widget.onPressedPanelLeft,
          icon: const Icon(
            Icons.subject,
            size: 24.0,
            color: AppColors.primary,
          ),
        ),
      ),
      body: Obx(
        () {
          final index = main.storeIndex.value;
          return BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              switch (state) {
                case ProductsLoadingState():
                  return const AppShimmerLoadingProductsWidget();
                case ProductsFailureState():
                  return Text("${state.failure}");
                case ProductsErrorState():
                  if (state.error ==
                      "Exception: type 'Null' is not a subtype of type 'Map<String, dynamic>'") {
                    return AppEmptyProductWidget(
                      index: index,
                      inCategoryEmpty: false,
                    );
                  }
                  return Text("${state.error}");
                case ProductsGetSuccessState():
                  List<ProductsEntity>? results =
                      filteredProducts(state.entity, index, searchTerm);
                  if (results?.isEmpty ?? true) {
                    return AppEmptyProductWidget(
                      index: index,
                      inCategoryEmpty: true,
                    );
                  } else {
                    return RefreshIndicator.adaptive(
                      displacement: 10,
                      backgroundColor: AppColors.primary,
                      color: Platform.isIOS ? Colors.black : Colors.white,
                      onRefresh: () async {
                        bloc.add(const ProductsGetRefreshEvent());
                      },
                      child: ListView.builder(
                        itemCount: results?.length,
                        padding: const EdgeInsets.only(top: 16),
                        clipBehavior: Clip.none,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Obx(
                              () => SalesCardProductsWidget(
                                color: carts.isProductsInCart.value
                                    ? AppColors.primary
                                    : Colors.white,
                                entity: results?[index],
                                onTapToCarts: () async {
                                  carts.addToCarts(results![index]);
                                  carts.updateCartCalculations();
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                default:
                  return Text("${state.error}");
              }
            },
          );
        },
      ),
    );
  }

  List<ProductsEntity>? filteredProducts(
      ListProductsEntity? data, int index, String searchTerm) {
    if (data != null) {
      List<ProductsEntity> filteredList = data.products!
          .where((product) =>
              product.category == MenuCategory.values[index].name &&
              product.name!.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      return filteredList;
    }

    // Add a default return statement if data is null
    return null;
  }
}
