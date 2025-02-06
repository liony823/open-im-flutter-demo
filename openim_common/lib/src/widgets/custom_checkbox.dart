import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_common/openim_common.dart';

///Widget that draw a beautiful checkbox rounded. Provided with animation if wanted
class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    super.key,
    this.isChecked,
    this.checkedWidget,
    this.uncheckedWidget,
    this.checkedColor,
    this.uncheckedColor,
    this.disabledColor,
    this.border,
    this.borderColor,
    this.size,
    this.iconSize,
    this.animationDuration,
    this.isRound = true,
    required this.onTap,
  });

  ///Define wether the checkbox is marked or not
  final bool? isChecked;

  ///Define the widget that is shown when Widgets is checked
  final Widget? checkedWidget;

  ///Define the widget that is shown when Widgets is unchecked
  final Widget? uncheckedWidget;

  ///Define the color that is shown when Widgets is checked
  final Color? checkedColor;

  ///Define the color that is shown when Widgets is unchecked
  final Color? uncheckedColor;

  ///Define the color that is shown when Widgets is disabled
  final Color? disabledColor;

  ///Define the border of the widget
  final Border? border;

  ///Define the border color  of the widget
  final Color? borderColor;

  ///Define the size of the checkbox
  final double? size;

  ///Define the size of the icon
  final double? iconSize;

  ///Define Function that os executed when user tap on checkbox
  ///If onTap is given a null callack, it will be disabled
  final Function(bool?)? onTap;

  ///Define the duration of the animation. If any
  final Duration? animationDuration;

  final bool isRound;

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool? isChecked;
  late Duration animationDuration;
  double? size;
  double? iconSize;
  Widget? checkedWidget;
  Widget? uncheckedWidget;
  Color? checkedColor;
  Color? uncheckedColor;
  Color? disabledColor;
  late Color borderColor;

  @override
  void initState() {
    isChecked = widget.isChecked ?? false;
    animationDuration =
        widget.animationDuration ?? const Duration(milliseconds: 300);
    size = widget.size ?? 24.0;
    iconSize = widget.iconSize ?? 16.sp;
    checkedColor = widget.checkedColor ?? Styles.c_0089FF;
    uncheckedColor = widget.uncheckedColor;
    borderColor = widget.borderColor ?? Styles.c_0089FF;
    checkedWidget = widget.checkedWidget ??
        Icon(Icons.check, color: Styles.c_FFFFFF, size: iconSize);
    uncheckedWidget = widget.uncheckedWidget ?? const SizedBox.shrink();
    super.initState();
  }

  @override
  void didUpdateWidget(CustomCheckBox oldWidget) {
    uncheckedColor =
        widget.uncheckedColor ?? Theme.of(context).scaffoldBackgroundColor;
    if (isChecked != widget.isChecked) {
      isChecked = widget.isChecked ?? false;
    }
    if (animationDuration != widget.animationDuration) {
      animationDuration =
          widget.animationDuration ?? const Duration(milliseconds: 300);
    }
    if (size != widget.size) {
      size = widget.size ?? 24.0;
    }
    if (iconSize != widget.iconSize) {
      iconSize = widget.iconSize ?? 16.sp;
    }
    if (checkedColor != widget.checkedColor) {
      checkedColor = widget.checkedColor ?? Styles.c_0089FF;
    }
    if (borderColor != widget.borderColor) {
      borderColor = widget.borderColor ?? Styles.c_0089FF;
    }
    if (checkedWidget != widget.checkedWidget) {
      checkedWidget = widget.checkedWidget ??
          Icon(Icons.check, color: Styles.c_FFFFFF, size: iconSize);
    }
    if (uncheckedWidget != widget.uncheckedWidget) {
      uncheckedWidget = widget.uncheckedWidget ?? const SizedBox.shrink();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.onTap != null
        ? GestureDetector(
            onTap: () {
              setState(() => isChecked = !isChecked!);
              widget.onTap!(isChecked);
            },
            child: ClipRRect(
              borderRadius: borderRadius,
              child: AnimatedContainer(
                duration: animationDuration,
                height: size,
                width: size,
                decoration: BoxDecoration(
                  color: isChecked! ? checkedColor : uncheckedColor,
                  border: widget.border ??
                      Border.all(
                        color: borderColor,
                      ),
                  borderRadius: borderRadius,
                ),
                child:
                    Center(child: isChecked! ? checkedWidget : uncheckedWidget),
              ),
            ),
          )
        : ClipRRect(
            borderRadius: borderRadius,
            child: AnimatedContainer(
              duration: animationDuration,
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: widget.disabledColor ?? Theme.of(context).disabledColor,
                border: widget.border ??
                    Border.all(
                      color: widget.disabledColor ??
                          Theme.of(context).disabledColor,
                    ),
                borderRadius: borderRadius,
              ),
              child:
                  Center(child: isChecked! ? checkedWidget : uncheckedWidget),
            ),
          );
  }

  BorderRadius get borderRadius {
    if (widget.isRound) {
      return BorderRadius.circular(size! / 2);
    } else {
      return BorderRadius.zero;
    }
  }
}
