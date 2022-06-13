import 'package:flutter/material.dart';
import 'package:recipe_app/constants/theme_constants.dart';

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
  super.key,
  this.onPressed,
  required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: ThemeConst.lightTheme.hoverColor,
      ),
    );
  }
}