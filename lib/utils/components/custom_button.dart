import 'package:flutter/material.dart';

class CustomElevatedButtom extends StatelessWidget {
  final String? text;
  final VoidCallback? onPress;
  final Widget? child;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final Widget? imageIcon;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderSize;

  const CustomElevatedButtom({
    this.text,
    this.onPress,
    Key? key,
    this.child,
    this.color,
    this.borderColor,
    this.textColor,
    this.imageIcon,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w600,
    this.borderSize,
  }) : super(key: key);

  get _color => color ?? Colors.deepPurpleAccent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          primary: _color,
          shape: RoundedRectangleBorder(
            borderRadius: borderSize == null
                ? BorderRadius.circular(12)
                : BorderRadius.circular(borderSize!),
            side: BorderSide(
              color: borderColor ?? _color,
            ),
          ),
        ),
        child: text != null
            ? _Child(
                text: text!,
                textColor: textColor,
                imageIcon: imageIcon,
                fontSize: fontSize!,
                fontWeight: fontWeight!,
              )
            : child,
      ),
    );
  }
}

class _Child extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Widget? imageIcon;
  final double fontSize;
  final FontWeight fontWeight;

  const _Child({
    Key? key,
    required this.text,
    this.textColor,
    this.imageIcon,
    required this.fontSize,
    required this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: imageIcon != null
          ? MainAxisAlignment.spaceAround
          : MainAxisAlignment.center,
      children: [
        if (imageIcon != null) imageIcon!,
        Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.green,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
