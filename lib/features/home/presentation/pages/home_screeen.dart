import 'package:altaqwaa_new/core/service/service_locator.dart';
import 'package:altaqwaa_new/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:altaqwaa_new/features/auth/presentation/pages/login_screen.dart';
import 'package:altaqwaa_new/features/home/presentation/blocs/home_cubit/home_cubit.dart';
import 'package:altaqwaa_new/features/home/presentation/widgets/build_user_list.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AuthCubit, AuthStatess>(
      listener: (context, AuthStatess state) {},
      builder: (BuildContext context, AuthStatess state) {

        var cubit = AuthCubit.get(context);

        return  Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text('Home'),
            centerTitle: true,
            actions: [
              IconButton(onPressed: (){
                cubit.logout();
              }, icon: const Icon(Icons.logout)),
            ],
          ),
          body: const BuildUsersList(),
        );

      },
    );

  }
}
