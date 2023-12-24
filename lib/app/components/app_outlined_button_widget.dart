import 'package:flutter/material.dart';

class AppOutlineButtonWidget extends StatelessWidget {
  const AppOutlineButtonWidget({super.key, this.onPressed, this.child});

  final Widget? child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(),
      child: child,
    );
  }
}

class AppOutlineButtonIconWidget extends StatelessWidget {
  const AppOutlineButtonIconWidget({super.key, this.onPressed, this.child});
  final Widget? child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(),
      child: child,
    );
  }
}
