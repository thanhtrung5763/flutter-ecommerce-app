import 'package:flutter/material.dart';

class CustomDialogBorder extends ShapeBorder {
  final bool usePadding;

  CustomDialogBorder({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: usePadding ? 20 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight - Offset(0, 20));
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(0)))
      ..moveTo(rect.topCenter.dx - 90, rect.topCenter.dy)
      ..relativeLineTo(10, -10)
      ..relativeLineTo(10, 10)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
