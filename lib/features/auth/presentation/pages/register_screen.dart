
import 'package:altaqwaa_new/core/service/service_locator.dart';
import 'package:altaqwaa_new/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:altaqwaa_new/features/auth/presentation/widgets/custom_button.dart';
import 'package:altaqwaa_new/features/auth/presentation/widgets/password_textformfield.dart';
import 'package:altaqwaa_new/features/auth/presentation/widgets/show_loading_indicator.dart';
import 'package:altaqwaa_new/shared_widgets/custom_textfield.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final adaptiveColor = isDarkTheme ? Colors.white : Colors.black;
    final adaptiveTextColorButton = isDarkTheme ? Colors.black : Colors.white;
    return BlocConsumer<AuthCubit, AuthStatess>(
      listener: (context, AuthStatess state) {
        if (state is RegisterLoadingState) {
          showLoadingIndicator(context);
        }
        if (state is RegisterSuccessState) {
          AuthCubit.get(context).emailController.clear();
          AuthCubit.get(context).passwordController.clear();

          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const LoginScreen()), (route) => false);
        }
        if (state is RegisterFailedState) {
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, AuthStatess state) {

        var cubit = AuthCubit.get(context);

        return Scaffold(
          backgroundColor:  Theme.of(context).primaryColor,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Icon(Icons.chat, size: 100, color: adaptiveColor),
                  SizedBox(
                    height: 60.h,
                  ),
                  Form(
                    key: cubit.formKeyRegister,
                    child: Column(
                      children: [
                        ///====== email ====///
                        Container(
                          padding: const EdgeInsetsDirectional.all(15.0),
                          child:  CustomTextFormField(
                            obscureText: false,
                            textColor: adaptiveColor,
                            validator: (value) {
                              return null;
                            },
                            textEditingController:
                            cubit.emailController,
                            prefixIcon: Icons.email,
                            hintText: "Email",
                            keyBoardType: TextInputType.emailAddress,
                          ),
                        ),


                        ///==== password ====///
                        Container(
                          padding: const EdgeInsetsDirectional.all(15.0),
                          child: PasswordTextFormField(
                            hintText: 'Password',
                            textColor: adaptiveColor,
                            functionUseToShowAndHidePassWord: () =>
                                AuthCubit.get(context).isShowAndHidePassWord(),
                            isShowPasswordOrNot: AuthCubit.get(context).isShow,
                            passwordController: cubit.passwordController,
                            suffixIcon: AuthCubit.get(context).suffix,
                          ),
                        ),

                        ///==== confirm password ====///

                        Container(
                          padding: const EdgeInsetsDirectional.all(15.0),
                          child: PasswordTextFormField(
                            hintText: 'Confirm Password',
                            textColor: adaptiveColor,
                            functionUseToShowAndHidePassWord: () =>
                                AuthCubit.get(context).isShowAndHidePassWord(),
                            isShowPasswordOrNot: AuthCubit.get(context).isShow,
                            passwordController: cubit.confirmPasswordController,
                            suffixIcon: AuthCubit.get(context).suffix,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        CustomButton(
                          widthButton: 350.w,
                          colorButton: adaptiveColor,
                          onPressed: () async {
                            if (cubit.formKeyRegister.currentState!.validate()) {
                              if(cubit.passwordController.text == cubit.confirmPasswordController.text){
                                AuthCubit.get(context).register(
                                  email: cubit.emailController.text,
                                  password: cubit.passwordController.text,
                                );
                              }

                              else{
                                showDialog(context: context, builder: (context)=>const AlertDialog(
                                  title: Text('Password Not Match'),
                                ));
                              }

                            }
                          },
                          textButton: "Register",
                          textColor: adaptiveTextColorButton,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Already have account ?",
                                style:  TextStyle(
                                    fontSize: 16.sp,
                                    color: adaptiveColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              TextButton(
                                onPressed: () {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context)=>const LoginScreen())
                                    , (route) => false);
                                  AuthCubit.get(context).registerScreen = true;
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF008CFF),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

  }
}
