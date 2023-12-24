import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:flutter/material.dart';

import '../../../../common/utils/app_shimmer_widget.dart';

class CustomersShimmerLoadingWidget extends StatelessWidget {
  const CustomersShimmerLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 16),
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        return Container(
          width: context.screenWidth,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(left: 12, right: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppShimmerWidget(
                radius: 4,
                height: 14,
                width: 80,
              ),
              12.height,
              Row(
                children: [
                  const Flexible(
                    child: AppShimmerWidget(
                      radius: 4,
                      height: 10,
                      width: 100,
                    ),
                  ),
                  12.width,
                  const Flexible(
                    flex: 2,
                    child: AppShimmerWidget(
                      radius: 4,
                      height: 10,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
