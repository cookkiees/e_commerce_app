import 'package:flutter/material.dart';

extension ShowBottomSheetExtension on BuildContext {
  void appBottomSheet(
      {required Widget bottomSheetContent, bool isScrollControlled = false}) {
    showModalBottomSheet(
      context: this,
      useRootNavigator: true,
      backgroundColor: Colors.white,
      showDragHandle: true,
      isScrollControlled: isScrollControlled,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      builder: (BuildContext context) {
        return bottomSheetContent;
      },
    );
  }

  void appBottomSheetText({required String message}) {
    showModalBottomSheet(
      context: this,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(message),
        );
      },
    );
  }
}
