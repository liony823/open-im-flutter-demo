import 'package:flutter/material.dart';

class RectIndicator extends Decoration {
  /// topRight radius of the indicator, default to 5.
  final double topRightRadius;

  /// topLeft radius of the indicator, default to 5.
  final double topLeftRadius;

  /// bottomRight radius of the indicator, default to 0.
  final double bottomRightRadius;

  /// bottomLeft radius of the indicator, default to 0
  final double bottomLeftRadius;

  /// Color of the indicator, default set to [Colors.black]
  final Color color;

  /// 渐变色
  final LinearGradient? gradient;

  /// Vertical padding of the indicator, default set to 0
  final double bottomPadding;

  final double leftPadding;

  final double width;

  final double height;

  const RectIndicator({
    this.topRightRadius = 5,
    this.topLeftRadius = 5,
    this.bottomRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.color = Colors.black,
    this.gradient,
    this.bottomPadding = 0,
    this.leftPadding = 0,
    this.width = 100,
    this.height = 2,
  });
  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(this, onChanged,
        bottomLeftRadius: bottomLeftRadius,
        bottomRightRadius: bottomRightRadius,
        color: color,
        gradient: gradient,
        topLeftRadius: topLeftRadius,
        topRightRadius: topRightRadius,
        bottomPadding: bottomPadding,
        leftPadding: leftPadding,
        width: width,
        height: height);
  }
}

class _CustomPainter extends BoxPainter {
  final RectIndicator decoration;
  final double topRightRadius;
  final double topLeftRadius;
  final double bottomRightRadius;
  final double bottomLeftRadius;
  final Color color;
  final LinearGradient? gradient;
  final double bottomPadding;
  final double leftPadding;
  final double width;
  final double height;
  _CustomPainter(
    this.decoration,
    VoidCallback? onChanged, {
    required this.topRightRadius,
    required this.topLeftRadius,
    required this.bottomRightRadius,
    required this.bottomLeftRadius,
    required this.color,
    required this.gradient,
    required this.bottomPadding,
    required this.leftPadding,
    required this.width,
    required this.height,
  }) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Size mysize = Size(width, height);

    // Calculate position from left edge
    double startX = offset.dx + leftPadding;
    double startY =
        offset.dy + configuration.size!.height - bottomPadding - height;

    Offset myoffset = Offset(startX, startY);

    final Rect rect = myoffset & mysize;
    final Paint paint = Paint();
    if (gradient != null) {
      paint.shader = gradient!.createShader(rect);
    } else {
      paint.color = color;
    }
    paint.strokeWidth = 3;
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          rect,
          bottomRight: Radius.circular(bottomRightRadius),
          bottomLeft: Radius.circular(bottomLeftRadius),
          topLeft: Radius.circular(topLeftRadius),
          topRight: Radius.circular(topRightRadius),
        ),
        paint);
  }
}
