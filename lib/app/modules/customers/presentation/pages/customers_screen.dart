import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:e_commerce_app/app/modules/customers/presentation/bloc/customers_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../main/controllers/main_controller.dart';
import '../../domain/entities/customers_entity.dart';
import '../extensions/customers_extension.dart';
import '../widgets/customers_shimmer_loading_widget.dart';

class CustomersScreen extends GetView<MainController> {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activity = BlocProvider.of<CustomersBloc>(context);
    activity.add(CustomersGetInitialEvent());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: false,
        title: "Customers".asSubtitleBig(fontWeight: FontWeight.w400),
      ),
      body: NestedScrollView(headerSliverBuilder: (context, _) {
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
                    var selected = controller.selectedActivity.value;
                    return Wrap(
                      spacing: 12,
                      children: CustomersCategory.values.asMap().entries.map(
                        (e) {
                          var index = e.key;
                          var catrgory = e.value;
                          return InkWell(
                            onTap: () {
                              controller.setSelectedActivity(e.key);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
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
                        },
                      ).toList(),
                    );
                  },
                ),
              ),
            ),
          )
        ];
      }, body: Obx(() {
        final index = controller.selectedCustomers.value;
        CustomersCategory selectedCategory = CustomersCategory.values[index];
        return BlocBuilder<CustomersBloc, CustomersState>(
          builder: (context, state) {
            switch (state) {
              case CustomersLoading():
                return const CustomersShimmerLoadingWidget();
              case CustomersFailure():
                return const SizedBox.shrink();
              case CustomersError():
                return const SizedBox.shrink();
              case CustomersGetSuccess():
                List<CustomersEntity>? results =
                    filteredCustomers(state.entity, selectedCategory);

                if (results != null) {
                  return ListView.builder(
                    itemCount: results.length,
                    padding:
                        const EdgeInsets.only(left: 14, right: 16, top: 16),
                    itemBuilder: (BuildContext context, int index) {
                      final customer = results[index];
                      DateTime lastOrderDateTime =
                          DateTime.parse(customer.lastOrder ?? '');

                      String formattedDate =
                          DateFormat('d MMMM yyyy').format(lastOrderDateTime);
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(width: 0.5, color: AppColors.primary),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.person_outline,
                                  size: 18.0,
                                  color: AppColors.primary,
                                ),
                                8.width,
                                '${customer.name?[0].toUpperCase()}${customer.name?.substring(1)}'
                                    .asSubtitleNormal(
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            8.height,
                            Row(
                              children: [
                                'Last order '.asSubtitleNormal(),
                                Shimmer.fromColors(
                                  baseColor: Colors.green,
                                  highlightColor: Colors.white,
                                  child: const Icon(
                                    Icons.keyboard_double_arrow_right,
                                    size: 16,
                                    color: Colors.green,
                                  ),
                                ),
                                8.width,
                                formattedDate.asSubtitleNormal(),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.group,
                          size: 24.0,
                          color: Colors.grey,
                        ),
                        8.height,
                        "You don't have any Customers"
                            .asSubtitleNormal(color: Colors.grey),
                      ],
                    ),
                  );
                }

              default:
                return const SizedBox.shrink();
            }
          },
        );
      })),
    );
  }

  List<CustomersEntity>? filteredCustomers(
    ListCustomersEntity? data,
    CustomersCategory selectedCategory,
  ) {
    if (data != null) {
      switch (selectedCategory) {
        case CustomersCategory.all:
          // Filter customers for "all"
          return data.customers;
        case CustomersCategory.today:
          // Filter customers for "today"
          DateTime today = DateTime.now();
          return data.customers?.where((customer) {
            // Convert the lastOrder String to DateTime for comparison
            DateTime lastOrderDateTime =
                DateTime.parse(customer.lastOrder ?? '');
            // Check if lastOrder is after yesterday
            return lastOrderDateTime
                .isAfter(today.subtract(const Duration(days: 1)));
          }).toList();
        default:
          return null; // Handle other cases if needed
      }
    }
    return null; // Handle the case when data is null
  }
}
