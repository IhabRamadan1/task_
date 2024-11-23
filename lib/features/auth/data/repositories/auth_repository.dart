import 'dart:io';
import '../dataresources/auth_remote_dataresource.dart';

class AuthRepo {
  final AuthRemoteDataSource authWebServices;

  AuthRepo({required this.authWebServices});

 login(
      {required String email,
        required String password,
       }) async {
    var response = await authWebServices.login(
        email: email, password: password);
    return response;

  }


  ///logout

  logout() async {
    return await authWebServices.logout();
  }

  // ToDo Register Function
  register(
      {
        required String password,
        required String email,

        }) async {
     var response = await authWebServices.register(
       email: email,
       password: password,

     );
    return response;

  }


}
