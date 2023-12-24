import 'package:flutter/material.dart';

SizedBox buildAppLoadingButton() {
  return const SizedBox(
    height: 24,
    width: 24,
    child: CircularProgressIndicator(
      color: Colors.white,
      strokeWidth: 3,
    ),
  );
}
