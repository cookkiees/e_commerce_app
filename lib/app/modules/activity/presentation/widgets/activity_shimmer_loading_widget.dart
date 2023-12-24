import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:flutter/material.dart';

import '../../../../common/utils/app_shimmer_widget.dart';

class ActivityShimmerLoadingWidget extends StatelessWidget {
  const ActivityShimmerLoadingWidget({
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
            height: 180,
            padding: const EdgeInsets.only(left: 12, right: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppShimmerWidget(
                      radius: 4,
                      width: 140,
                      height: 16,
                    ),
                    AppShimmerWidget(
                      radius: 4,
                      width: 80,
                      height: 16,
                    ),
                  ],
                ),
                12.height,
                const AppShimmerWidget(
                  radius: 4,
                  height: 14,
                  width: 100,
                ),
                4.height,
                const AppShimmerWidget(
                  radius: 4,
                  height: 5,
                  width: double.infinity,
                ),
                4.height,
                12.height,
                const AppShimmerWidget(
                  radius: 4,
                  height: 14,
                  width: 100,
                ),
                4.height,
                const AppShimmerWidget(
                  radius: 4,
                  height: 14,
                  width: 100,
                ),
                4.height,
                const AppShimmerWidget(
                  radius: 4,
                  height: 5,
                  width: double.infinity,
                ),
                12.height,
                const AppShimmerWidget(
                  radius: 4,
                  height: 14,
                  width: 100,
                ),
                4.height,
              ],
            ),
          ),
        );
      },
    );
  }
}
