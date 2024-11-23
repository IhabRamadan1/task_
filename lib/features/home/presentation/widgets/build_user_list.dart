import 'package:altaqwaa_new/core/service/service_locator.dart';
import 'package:altaqwaa_new/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:altaqwaa_new/features/home/presentation/pages/chat_screen.dart';
import 'package:altaqwaa_new/features/home/presentation/blocs/home_cubit/home_cubit.dart';
import 'package:altaqwaa_new/features/home/presentation/widgets/user_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildUsersList extends StatelessWidget {
  const BuildUsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, HomeStates state) {},
      builder: (BuildContext context, HomeStates state) {
        var cubit = HomeCubit.get(context);

        return StreamBuilder<List<Map<String, dynamic>>>(
            stream: cubit.getUsers()
            , builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()),);
              }
               if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(),);
              }
                return
                  snapshot.data == null ?  const Center(child: Text('No Data'),) :
                  ListView(
                  children: snapshot.data!.map<Widget>((userData)=> _buildUserListItem(userData, context)).toList(),
                );
            }
        );
      },
        );
  }
}

Widget _buildUserListItem(Map<String,dynamic> userData, context) {

  if(userData['email'] != FirebaseAuth.instance.currentUser!.email){


  return UserTile(
    title: userData['email'],
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>   ChatScreen(email: userData['email'],

        receiverId: userData['uid'],)));
    },
  );
}
return const Text("");

}