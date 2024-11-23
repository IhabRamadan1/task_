import 'package:altaqwaa_new/features/home/presentation/pages/home_screeen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/Material.dart';

import 'login_screen.dart';

class AuthG extends StatelessWidget {
  const AuthG({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),

          builder: (context,snapshot){
            if(snapshot.hasData)  {
              return const HomeScreen();

            }
            else {
              return const LoginScreen();
            }
          }
      ),
    );
  }

}
