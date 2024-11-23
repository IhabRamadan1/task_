import 'package:flutter/Material.dart';


class CustomTextFormField extends StatelessWidget {
  final TextInputType keyBoardType;
  String? initialValue;
  final String hintText;
  final bool obscureText;
  Function? suffixFunction;
  IconData? suffixIcon;
  final Function validator;
  final TextEditingController textEditingController;
  IconData? prefixIcon;
  int? maxLines;
  Color? textColor;

  CustomTextFormField(
      {Key? key,
        required this.obscureText,
        required this.validator,
        this.suffixFunction,
        this.suffixIcon,
        this.initialValue,
        required this.textEditingController,
        required this.hintText,
        required this.textColor,
        this.prefixIcon,
        this.maxLines = 1,
        required this.keyBoardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      initialValue: initialValue,
      keyboardType: keyBoardType,
      obscureText: obscureText,
      controller: textEditingController,
      style:  TextStyle(
        fontSize: 15,
        color: textColor,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            // color:ColorManager.primaryColor
          ),
        ),
        fillColor: Colors.white,
        prefixIconColor: textColor,
        filled: true,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(suffixIcon),
          onPressed: () {
            suffixFunction!();
          },
        )
            : null,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            // color:ColorManager.primaryColor,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: hintText,
      ),
      validator: (value) {
        return validator(value);
      },
    );
  }
}
