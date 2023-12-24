import 'package:flutter/material.dart';

class AppElevatedButtonWidget extends StatelessWidget {
  const AppElevatedButtonWidget(
      {super.key, this.onPressed, this.child, this.style});

  final void Function()? onPressed;
  final Widget? child;
  final ButtonStyle? style;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style ?? ElevatedButton.styleFrom(),
      child: child ?? const SizedBox.shrink(),
    );
  }
}

class AppElevatedButtonIconWidget extends StatelessWidget {
  const AppElevatedButtonIconWidget(
      {super.key, this.onPressed, this.label, this.icon, this.style});

  final void Function()? onPressed;
  final Widget? label;
  final Widget? icon;
  final ButtonStyle? style;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: style,
      label: label ?? const SizedBox.shrink(),
      icon: icon ?? const SizedBox.shrink(),
    );
  }
}
