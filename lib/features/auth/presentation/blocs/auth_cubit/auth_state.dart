part of 'auth_cubit.dart';

abstract class AuthStatess {}

class AuthInitial extends AuthStatess {}

class ShowAndHidePassword extends AuthStatess {}

class ProfileImagePickedSuccessState extends AuthStatess {}

class ProfileImagePickedErrorState extends AuthStatess {}

class LoginLoadingState extends AuthStatess {}

class LoginSuccessState extends AuthStatess {}

class LoginFailedState extends AuthStatess {}

class RegisterLoadingState extends AuthStatess {}

class RegisterSuccessState extends AuthStatess {}

class RegisterFailedState extends AuthStatess {}


class LogoutLoadingState extends AuthStatess {}

class LogoutSuccessState extends AuthStatess {}


