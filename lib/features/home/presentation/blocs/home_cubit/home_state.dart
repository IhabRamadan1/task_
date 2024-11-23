part of 'home_cubit.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class GetUsersLoadingState extends HomeStates {}

class GetUsersSuccessState extends HomeStates {}

class GetUsersFailedState extends HomeStates {}

class RegisterLoadingState extends HomeStates {}

class RegisterSuccessState extends HomeStates {}

class RegisterFailedState extends HomeStates {}


class LogoutLoadingState extends HomeStates {}

class LogoutSuccessState extends HomeStates {}


