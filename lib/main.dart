import 'package:altaqwaa_new/features/auth/presentation/pages/auth_gate.dart';
import 'package:altaqwaa_new/features/auth/presentation/pages/login_screen.dart';
import 'package:altaqwaa_new/features/home/presentation/blocs/home_cubit/home_cubit.dart';
import 'package:altaqwaa_new/firebase_options.dart';
import 'package:altaqwaa_new/res/themes/light_mode.dart';
import 'package:bloc/bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_bloc_observer.dart';
import 'core/service/service_locator.dart';
import 'features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  ServicesLocator().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
        providers:
        [
          BlocProvider(
          create: (context)=>AuthCubit(sl()),),
          BlocProvider(
            create: (context)=>HomeCubit(sl()),),

    ],
          child:  ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          title: 'Chat',
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          home: const AuthG(),
        ),
            )

    );
  }
}


