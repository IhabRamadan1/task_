// ToDo Custom Button

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String textButton;
  Color? textColor;
  final Function()? onPressed;
  Color? colorButton;
  final double widthButton;
  final double borderRadiusButton;
  CustomButton(
      {Key? key,
        this.borderRadiusButton = 25,
        this.widthButton = 100,
        required this.textButton,
        required this.onPressed,
        this.colorButton,
        this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthButton,
      decoration: BoxDecoration(
        color: colorButton ?? Colors.yellow,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          textButton,
          style:
          TextStyle(color: textColor, fontSize: 16),
          maxLines: 1,
        ),
      ),
    );
  }
}

