import 'package:altaqwaa_new/features/auth/data/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStatess> {
   final AuthRepo _authRepo;

  AuthCubit( this._authRepo) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyRegister = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var confirmPasswordController = TextEditingController();






  // ToDo Function It is using to show and hide the password
  IconData suffix = Icons.visibility_off;
  bool isShow = true;

  void isShowAndHidePassWord() {
    isShow = !isShow;
    suffix = isShow ? Icons.visibility_off : Icons.remove_red_eye;
    emit(ShowAndHidePassword());
  }

  //ToDo
  bool? registerScreen;
  bool? loginScreen;



  // ToDo Login Function
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  login(
      {required String email,
      required String password,
      }) async {
    emit(LoginLoadingState());
    try {
      final result = await _authRepo.login(
          email: email, password: password);
      emit(LoginSuccessState());
    }
   catch (e) {
      emit(LoginFailedState());
    }
  }


  ///logout

  logout() async {
    emit(LogoutLoadingState());
    await _authRepo.logout();
    emit(LogoutSuccessState());
  }

  // ToDo Register Function
   register({
     required String password,
     required String email,
   }) async {
     emit(RegisterLoadingState());
     try {
       final result = await _authRepo.register(
         email: email,
         password: password,
       );
       emit(RegisterSuccessState());
     } catch (e) {
       emit(RegisterFailedState());
     }
   }




}
