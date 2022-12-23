import 'package:final_project/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ButtonIcon extends StatefulWidget {
  final IconData iconInActive;
  bool isTwoState;
  Color? iconColorInActive;
  Color? backgroundColorInActive;

  IconData? iconActivated;
  Color? iconColorActivated;
  Color? backgroundColorActivated;
  ButtonIcon({
    super.key,
    required this.iconInActive,
    this.iconColorInActive = AppColors.grey,
    this.backgroundColorInActive = AppColors.white,
    this.isTwoState = false,
  });

  ButtonIcon.twoState({
    super.key,
    required this.iconInActive,
    this.iconColorInActive = AppColors.grey,
    this.backgroundColorInActive = AppColors.white,
    this.iconActivated,
    this.iconColorActivated = AppColors.redPrimary,
    this.backgroundColorActivated = AppColors.redPrimary,
    this.isTwoState = true,
  });

  @override
  State<ButtonIcon> createState() => _ButtonIconState();
}

class _ButtonIconState extends State<ButtonIcon> {
  bool isPress = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: const CircleBorder(),
        color: widget.backgroundColorInActive,
        shadows: const [
          BoxShadow(
            color: Color(0xFFe8e8e8),
            blurRadius: 1.0,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          widget.isTwoState == true
              ? (isPress == false ? widget.iconInActive : widget.iconActivated)
              : widget.iconInActive,
          color: widget.isTwoState == true
              ? (isPress == false
                  ? widget.iconColorInActive
                  : widget.iconColorActivated)
              : widget.iconColorInActive,
        ),
        onPressed: () {
          setState(() {
            isPress = !isPress;
          });
        },
      ),
    );
  }
}
