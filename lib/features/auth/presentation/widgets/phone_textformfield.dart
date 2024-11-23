import 'package:altaqwaa_new/shared_widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneTextFormField extends StatelessWidget {
  PhoneTextFormField({super.key, required this.phoneController, required this.textColor});

  TextEditingController phoneController;
  Color? textColor;


  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      textColor: textColor,
      obscureText: false,
      keyBoardType: TextInputType.phone,
      prefixIcon: Icons.phone_android_outlined,
      hintText: 'Phone Number',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the phone number';
        }
        if (value.length != 11) {
          return 'number shorter than eleven digit';
        }
        String check = value.substring(0, 3);
        if (check != '010' &&
            check != '012' &&
            check != '011' &&
            check != '015') {
          return 'number is incorrect';
        }
        return null;
      },
      textEditingController: phoneController,
    );
  }
}
