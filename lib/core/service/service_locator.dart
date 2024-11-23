
import 'package:altaqwaa_new/features/auth/data/dataresources/auth_remote_dataresource.dart';
import 'package:altaqwaa_new/features/auth/data/repositories/auth_repository.dart';
import 'package:altaqwaa_new/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:altaqwaa_new/features/home/data/dataresources/home_remote_dataresource.dart';
import 'package:altaqwaa_new/features/home/data/repositories/home_repository.dart';
import 'package:altaqwaa_new/features/home/presentation/blocs/home_cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';





final sl = GetIt.instance;
class ServicesLocator {

  void init() {

    ///Bloc

    sl.registerFactory(() => AuthCubit(sl()));
    sl.registerFactory(() => HomeCubit(sl()));


    ///Repository
    sl.registerLazySingleton(() => AuthRepo( authWebServices: sl(),));
    sl.registerLazySingleton(() => HomeRepo(homeWebServices: sl(),));

    ///Data Source
    sl.registerLazySingleton(() =>AuthRemoteDataSource());
    sl.registerLazySingleton(() =>HomeRemoteDataSource());







  }
}