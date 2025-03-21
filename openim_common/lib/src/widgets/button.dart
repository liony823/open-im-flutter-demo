import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_common/openim_common.dart';
import 'package:vibration/vibration.dart';

enum ButtonType {
  primary,
  secondary,
  text,
  link,
}

enum ButtonSize {
  small,
  middle,
  large,
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.text,
    this.child,
    this.onTap,
    this.enabled = true,
    this.loading = false,
    this.block = true,
    this.size = ButtonSize.middle,
    this.type = ButtonType.primary,
    this.margin,
    this.padding,
    this.radius = 6.0,
    this.height,
    this.icon,
    this.color,
    this.textStyle,
    this.disabledTextStyle,
  });

  final String? text;
  final Widget? child;
  final Widget? icon;
  final VoidCallback? onTap;
  final bool enabled;
  final bool loading;
  final bool block;
  final ButtonSize size;
  final ButtonType type;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final double? height;
  final Color? color;
  final TextStyle? textStyle;
  final TextStyle? disabledTextStyle;

  double _getHeight() {
    switch (size) {
      case ButtonSize.small:
        return 32.h;
      case ButtonSize.middle:
        return 44.h;
      case ButtonSize.large:
        return 50.h;
    }
  }

  Color _getBackgroundColor() {
    if (!enabled) {
      return Styles.c_0089FF.withValues(alpha: .5);
    }

    if (type == ButtonType.primary) {
      return color ?? Styles.c_0089FF;
    }

    if (type == ButtonType.secondary) {
      return Colors.transparent;
    }

    return Colors.transparent;
  }

  TextStyle _getTextStyle() {
    if (!enabled) {
      return disabledTextStyle ??
          Styles.ts_FFFFFF_17_semibold
              .copyWith(color: Styles.c_FFFFFF.withValues(alpha: .5));
    }

    if (type == ButtonType.primary) {
      return textStyle ?? Styles.ts_FFFFFF_17_semibold;
    }

    if (type == ButtonType.secondary) {
      return textStyle ??
          Styles.ts_FFFFFF_17_semibold.copyWith(color: Styles.c_0089FF);
    }

    if (type == ButtonType.link) {
      return textStyle ??
          Styles.ts_FFFFFF_17_semibold.copyWith(
              color: Styles.c_0089FF, decoration: TextDecoration.underline);
    }

    return textStyle ?? Styles.ts_0089FF_17_semibold;
  }

  BoxBorder? _getBorder() {
    if (type == ButtonType.secondary) {
      return Border.all(
        color:
            enabled ? Styles.c_0089FF : Styles.c_0089FF.withValues(alpha: .5),
        width: 1,
      );
    }
    return null;
  }

  void _onTap() async {
    if (!enabled || loading) return;
    onTap?.call();
    final hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) {
      Vibration.vibrate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonHeight = height ?? _getHeight();

    return Container(
      width: block ? double.infinity : null,
      height: buttonHeight,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(radius.r),
            border: _getBorder(),
          ),
          child: InkWell(
            onTap: _onTap,
            borderRadius: BorderRadius.circular(radius.r),
            child: Container(
              padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisSize: block ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (loading) ...[
                    SizedBox(
                      width: 18.w,
                      height: 18.h,
                      child: CircularProgressIndicator(
                        color: _getTextStyle().color,
                        strokeWidth: 2.0,
                      ),
                    ),
                    8.horizontalSpace,
                  ],
                  if (icon != null && !loading) ...[
                    icon!,
                    8.horizontalSpace,
                  ],
                  child ??
                      Text(
                        text ?? '',
                        style: _getTextStyle(),
                        maxLines: 1,
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 为了保持向后兼容，保留 AdaptiveButton 类名但使用新的 Button 实现
class AdaptiveButton extends Button {
  const AdaptiveButton({
    super.key,
    super.text,
    super.child,
    super.onTap,
    super.enabled = true,
    super.loading = false,
    super.block = true,
    super.size = ButtonSize.large,
    super.margin,
    super.padding,
    super.radius = 8.0,
    super.height,
    Color? enabledColor,
    Color? disabledColor,
    super.textStyle,
    super.disabledTextStyle,
  }) : super(
          color: enabledColor,
          type: ButtonType.primary,
        );

  const AdaptiveButton.small({
    super.key,
    super.text,
    super.child,
    super.onTap,
    super.enabled = true,
    super.loading = false,
    super.block = true,
    super.margin,
    super.padding,
    super.radius = 8.0,
    super.height,
    Color? enabledColor,
    Color? disabledColor,
    super.textStyle,
    super.disabledTextStyle,
  }) : super(
          size: ButtonSize.small,
          color: enabledColor,
          type: ButtonType.primary,
        );
}

// ImageTextButton 重构
class ImageTextButton extends Button {
  ImageTextButton({
    super.key,
    required String icon,
    required String text,
    super.textStyle,
    super.color,
    super.height,
    super.onTap,
  }) : super(
          text: text,
          icon: icon.toImage
            ..width = 20.w
            ..height = 20.h,
          radius: 6,
        );

  ImageTextButton.call({super.key, super.onTap})
      : super(
          text: t.audioAndVideoCall,
          icon: ImageRes.audioAndVideoCall.toImage
            ..width = 20.w
            ..height = 20.h,
          color: Styles.c_FFFFFF,
          radius: 6,
        );

  ImageTextButton.message({super.key, super.onTap})
      : super(
          text: t.sendMessage,
          icon: ImageRes.message.toImage
            ..width = 20.w
            ..height = 20.h,
          color: Styles.c_0089FF,
          textStyle: Styles.ts_FFFFFF_17,
          radius: 6,
        );
}
