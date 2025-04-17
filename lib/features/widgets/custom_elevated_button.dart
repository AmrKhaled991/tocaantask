import 'package:flutter/material.dart';
import 'package:tocaantask/features/widgets/base_button.dart';
import 'package:tocaantask/features/widgets/default_progress_indicator.dart';

class CustomElevatedButton extends BaseButton {
  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Widget? centerIcon;
  final bool? isLoading;

  CustomElevatedButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.centerIcon,
    this.isLoading = false,
    super.margin,
    super.onPressed,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    required super.text,
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
          alignment: alignment ?? AlignmentDirectional.center,
          child: buildElevatedButtonWidget,
        )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
    height: height ?? 56,
    width: width,
    margin: margin,
    decoration: decoration,
    child: ElevatedButton(
      style: buttonStyle,
      onPressed: isDisabled ?? false ? null : onPressed ?? () {},
      child: buildChild(),
    ),
  );

  Widget buildChild() {
    if (isLoading ?? false) {
      return const DefaultProgressIndicator(
        size: 25,
        strokeWidth: 2,
        color: Colors.white,
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 10),
          child: leftIcon ?? const SizedBox.shrink(),
        ),
        const Spacer(),
        Text(
          text,
          textAlign: TextAlign.center,
          style: buttonTextStyle ?? TextStyle(color: Colors.white),
        ),
        centerIcon ?? const SizedBox.shrink(),
        const Spacer(),
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 10),
          child: rightIcon ?? const SizedBox.shrink(),
        ),
      ],
    );
  }
}
