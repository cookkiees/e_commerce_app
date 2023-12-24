import 'package:flutter/material.dart';
import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';

import '../common/utils/app_shimmer_widget.dart';

class AppShimmerLoadingProductsWidget extends StatelessWidget {
  const AppShimmerLoadingProductsWidget({
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
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            width: context.screenWidth,
            height: 80,
            padding: const EdgeInsets.only(left: 12, right: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppShimmerWidget(
                  radius: 4,
                  width: 80,
                  height: double.infinity,
                ),
                12.width,
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppShimmerWidget(
                        radius: 4,
                        height: 10,
                        width: double.infinity,
                      ),
                      4.height,
                      const AppShimmerWidget(radius: 4, height: 10, width: 200),
                      8.height,
                      const AppShimmerWidget(radius: 4, height: 10, width: 100),
                      const Spacer(),
                      const AppShimmerWidget(radius: 4, height: 20, width: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
