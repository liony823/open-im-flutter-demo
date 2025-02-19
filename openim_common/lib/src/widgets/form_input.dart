import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_common/openim_common.dart';

class FormInput extends StatefulWidget {
  const FormInput.password(
      {super.key,
      required this.name,
      this.controller,
      this.label,
      this.labelIcon,
      this.labelWidget,
      this.hintText,
      this.hintStyle,
      this.labelStyle,
      this.textInputAction,
      this.keyboardType = TextInputType.visiblePassword,
      this.obscureText = true,
      this.suffixIcon,
      this.prefixIcon,
      this.onSubmitted,
      this.validator});

  const FormInput.phone(
      {super.key,
      required this.name,
      this.controller,
      this.label,
      this.labelIcon,
      this.labelWidget,
      this.hintText,
      this.hintStyle,
      this.labelStyle,
      this.textInputAction,
      this.keyboardType = TextInputType.phone,
      this.obscureText = false,
      this.suffixIcon,
      this.prefixIcon,
      this.onSubmitted,
      this.validator});

  const FormInput(
      {super.key,
      required this.name,
      this.controller,
      this.label,
      this.labelIcon,
      this.labelWidget,
      this.hintText,
      this.hintStyle,
      this.labelStyle,
      this.textInputAction,
      this.keyboardType,
      this.obscureText = false,
      this.suffixIcon,
      this.prefixIcon,
      this.onSubmitted,
      this.validator});

  final String name;
  final TextEditingController? controller;
  final String? label;
  final IconData? labelIcon;
  final Widget? labelWidget;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onSubmitted;
  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  bool obscureText = false;

  Widget? get suffixIcon => widget.keyboardType == TextInputType.visiblePassword
      ? (obscureText
          ? IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: const Icon(EvaIcons.eyeOff2Outline))
          : IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: const Icon(EvaIcons.eyeOutline)))
      : widget.suffixIcon;

  @override
  void initState() {
    super.initState();
    setState(() {
      obscureText = widget.obscureText ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.w,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelWidget ??
            Row(
              spacing: 6.w,
              children: [
                Icon(widget.labelIcon, color: Styles.c_333333),
                Text(
                  widget.label ?? "",
                  style: widget.labelStyle ?? Styles.ts_000033_14_medium,
                ),
              ],
            ),
        FormBuilderTextField(
          name: widget.name,
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          obscureText: obscureText,
          validator: widget.validator,
          onSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: widget.prefixIcon,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ?? Styles.ts_999999_14_medium,
            filled: true,
            fillColor: Styles.c_E8EAEF.withValues(alpha: .5),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 28.w,
              vertical: 12.h,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: const BorderSide(color: Styles.c_E8EAEF)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: const BorderSide(color: Styles.c_DE473E)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: const BorderSide(color: Styles.c_DE473E)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: BorderSide.none),
          ),
        )
      ],
    );
  }
}
