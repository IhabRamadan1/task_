import 'package:altaqwaa_new/shared_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
   PasswordTextFormField({
    super.key,
    required this.passwordController,
    required this.suffixIcon,
    required this.textColor,
    required this.functionUseToShowAndHidePassWord,
    required this.isShowPasswordOrNot,
    this.hintText = '',
  });

  final TextEditingController passwordController;
  Color? textColor;

  final IconData suffixIcon;
  final Function functionUseToShowAndHidePassWord;
  final bool isShowPasswordOrNot;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      keyBoardType: TextInputType.visiblePassword,
      prefixIcon: Icons.lock,
      hintText: hintText,

      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter the password";
        }
        if (value.length < 8) {
          return "The password must be no less than 8 numbers";
        }
        return null;
      },
      textEditingController: passwordController,
      suffixIcon: suffixIcon,
      suffixFunction: () {
        functionUseToShowAndHidePassWord();
      },
      obscureText: isShowPasswordOrNot,

      textColor: textColor,
    );
  }
}
