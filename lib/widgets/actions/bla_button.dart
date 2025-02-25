import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

enum ButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final ButtonType buttonType;
  final bool hasIcon;
  final Icon? icon;
  final OutlinedBorder? shape;

  const BlaButton({
    Key? key,
    required this.text,
    required this.onPress,
    this.buttonType = ButtonType.primary,
    this.hasIcon = false,
    this.icon,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(BlaSpacings.radius)),
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = buttonType == ButtonType.primary;
    final textColor = isPrimary ? BlaColors.white : BlaColors.primary;
    final backgroundColor = isPrimary ? BlaColors.primary : BlaColors.white;

    final textStyle = BlaTextStyles.button.copyWith(
      color: textColor,
    );
    final buttonText = Text(text, style: textStyle);
    final iconColor = isPrimary ? BlaColors.white : BlaColors.primary;

    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: shape,
      ),
      child: hasIcon
          ? IconTheme(
              data: IconThemeData(color: iconColor),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon ?? Icon(Icons.accessibility),
                  SizedBox(width: 4),
                  buttonText,
                ],
              ),
            )
          : buttonText,
    );
  }
}
