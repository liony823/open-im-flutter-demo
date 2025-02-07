import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_common/openim_common.dart';

enum ButtonSize {
  small,
  medium,
  large,
}

class AdaptiveButton extends StatelessWidget {
  const AdaptiveButton({
    super.key,
    this.text,
    this.child,
    this.onTap,
    this.enabled = true,
    this.loading = false,
    this.block = true,
    this.size = ButtonSize.large,
    this.margin,
    this.padding,
    this.radius = 8.0,
    this.height,
    this.enabledColor,
    this.disabledColor = CupertinoColors.tertiarySystemFill,
    this.textStyle,
    this.disabledTextStyle,
  });

  const AdaptiveButton.small({
    super.key,
    this.text,
    this.child,
    this.onTap,
    this.enabled = true,
    this.loading = false,
    this.block = true,
    this.size = ButtonSize.small,
    this.margin,
    this.padding,
    this.radius = 8.0,
    this.height,
    this.enabledColor,
    this.disabledColor = CupertinoColors.tertiarySystemFill,
    this.textStyle,
    this.disabledTextStyle,
  });

  /// 按钮文本
  final String? text;

  final Widget? child;

  final double? height;

  /// 点击回调
  final VoidCallback? onTap;

  /// 是否启用
  final bool enabled;

  /// 是否显示加载中
  final bool loading;

  /// 是否占满宽度
  final bool block;

  /// 按钮大小样式
  final ButtonSize size;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 圆角大小
  final double radius;

  /// 启用状态下的背景色
  final Color? enabledColor;

  /// 禁用状态下的背景色
  final Color? disabledColor;

  /// 文本样式
  final TextStyle? textStyle;

  /// 禁用状态下的文本样式
  final TextStyle? disabledTextStyle;

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    double h = 44.h;
    if (size == ButtonSize.small) {
      h = 32.h;
    } else if (size == ButtonSize.large) {
      h = 50.h;
    }
    if (platform == TargetPlatform.iOS) {
      CupertinoButtonSize sizeStyle = CupertinoButtonSize.medium;
      if (size == ButtonSize.small) {
        sizeStyle = CupertinoButtonSize.small;
      } else if (size == ButtonSize.medium) {
        sizeStyle = CupertinoButtonSize.medium;
      } else if (size == ButtonSize.large) {
        sizeStyle = CupertinoButtonSize.large;
      }
      return Container(
        width: block ? double.infinity : null,
        height: height ?? h,
        margin: margin,
        child: CupertinoButton(
          onPressed: !enabled
              ? null
              : () {
                  if (loading) return;
                  onTap?.call();
                },
          pressedOpacity: 0.8,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
          color: enabledColor ?? Styles.c_0089FF,
          disabledColor: disabledColor ?? CupertinoColors.tertiarySystemFill,
          sizeStyle: sizeStyle,
          borderRadius: BorderRadius.circular(radius.r),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            layoutBuilder: (child, List<Widget> previousChildren) => Stack(
              alignment: Alignment.center,
              children: [
                ...previousChildren,
                if (child != null) child,
              ],
            ),
            child: loading
                ? SizedBox(
                    width: 18.w,
                    height: 18.h,
                    child: CircularProgressIndicator(
                      color: Styles.c_FFFFFF,
                      strokeWidth: 3.0.r,
                    ),
                  )
                : child ??
                    Text(text ?? '',
                        style: enabled
                            ? (textStyle ?? Styles.ts_FFFFFF_17_semibold)
                            : (disabledTextStyle ??
                                textStyle ??
                                Styles.ts_FFFFFF_17_semibold)),
          ),
        ),
      );
    }

    return Button(
      text: text,
      onTap: onTap,
      enabled: enabled,
      loading: loading,
      height: height,
      margin: margin,
      padding: padding,
      radius: radius,
      enabledColor: enabledColor,
      disabledColor: disabledColor,
      textStyle: textStyle,
      disabledTextStyle: disabledTextStyle,
      child: child,
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.text,
    this.child,
    this.enabled = true,
    this.enabledColor,
    this.disabledColor,
    this.radius,
    this.textStyle,
    this.disabledTextStyle,
    this.onTap,
    this.margin,
    this.padding,
    this.height,
    this.loading = false,
  });
  final Color? enabledColor;
  final Color? disabledColor;
  final double? radius;
  final TextStyle? textStyle;
  final TextStyle? disabledTextStyle;
  final String? text;
  final Widget? child;
  final double? height;
  final Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool enabled;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    double height = this.height ?? 44.h;
    return Container(
      margin: margin,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          height: height,
          decoration: BoxDecoration(
            color: enabled
                ? enabledColor ?? Styles.c_0089FF
                : disabledColor ?? Styles.c_0089FF.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(radius ?? 4.r),
          ),
          child: InkWell(
            onTap: enabled ? onTap : null,
            borderRadius: BorderRadius.circular(radius ?? 4.r),
            child: Container(
              alignment: Alignment.center,
              padding: padding,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                layoutBuilder: (child, List<Widget> previousChildren) => Stack(
                  children: [
                    ...previousChildren,
                    if (child != null) child,
                  ],
                ),
                child: loading
                    ? const CircularProgressIndicator(
                        color: Styles.c_FFFFFF,
                        strokeWidth: 2.0,
                      )
                    : child ??
                        Text(
                          text ?? '',
                          style: textStyle ?? Styles.ts_FFFFFF_17_semibold,
                          maxLines: 1,
                        ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageTextButton extends StatelessWidget {
  const ImageTextButton({
    super.key,
    required this.icon,
    required this.text,
    this.textStyle,
    this.color,
    this.height,
    this.onTap,
  });
  final String icon;
  final String text;
  final TextStyle? textStyle;
  final Color? color;
  final double? height;
  final Function()? onTap;

  ImageTextButton.call({super.key, this.onTap})
      : icon = ImageRes.audioAndVideoCall,
        text = StrRes.audioAndVideoCall,
        color = Styles.c_FFFFFF,
        textStyle = null,
        height = null;

  ImageTextButton.message({super.key, this.onTap})
      : icon = ImageRes.message,
        text = StrRes.sendMessage,
        color = Styles.c_0089FF,
        textStyle = Styles.ts_FFFFFF_17,
        height = null;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        height: height ?? 46.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: color,
        ),
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon.toImage
                ..width = 20.w
                ..height = 20.h,
              6.horizontalSpace,
              text.toText..style = textStyle ?? Styles.ts_0C1C33_17,
            ],
          ),
        ),
      ),
    );
  }
}
