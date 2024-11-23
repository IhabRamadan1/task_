
import 'package:altaqwaa_new/res/themes/colors.dart';
import 'package:altaqwaa_new/res/themes/dark_mode.dart';
import 'package:altaqwaa_new/shared_widgets/custom_textfield.dart';
import 'package:flutter/Material.dart';
import 'package:altaqwaa_new/features/home/presentation/blocs/home_cubit/home_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  final String email;
  final String receiverId;


   ChatScreen({super.key, required this.email, required this.receiverId});

   var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: AppColors.senderColor.withOpacity(0.7),
        centerTitle: true,
        leading: IconButton(onPressed: (){

          Navigator.pop(context);

        },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),

        ),
        title: Text(email, style: const TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children:  [
            buildUserStatus(receiverId), // Online status
            buildTypingIndicator(receiverId), // Typing indicator
            Expanded(child: _buildMessageList(receiverId)),
            _buildUserInput(messageController, () {
              HomeCubit.get(context).sendMessage(receiverId, messageController.text);
              messageController.clear();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList(String receiverId) {
    String senderId = FirebaseAuth.instance.currentUser!.uid;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, HomeStates state) {},
      builder: (BuildContext context, HomeStates state) {
        var cubit = HomeCubit.get(context);

        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>> (
            stream: cubit.getMessages(receiverId, senderId)
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
              children: snapshot.data!.docs.map<Widget>((doc)=> _buildMessageItem(doc)).toList(),
            );
        }
        );
      },
    );

  }

}

Widget _buildMessageItem(DocumentSnapshot doc) {
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  bool isSender = data['senderId'] == FirebaseAuth.instance.currentUser!.uid;

  return Align(
    alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      constraints: const BoxConstraints(maxWidth: 250), // Limit bubble width
      decoration: BoxDecoration(
        color: isSender ? AppColors.senderColor : AppColors.receiverColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment:
        isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            data['message'],
            style: TextStyle(
              color: isSender ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(
              data['timestamp'].toString(), // Example time, update to actual timestamp
            style: TextStyle(
              color: isSender ? Colors.white70 : Colors.black45,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildUserInput(TextEditingController controller, VoidCallback onSend) {
  return Container(
    color:AppColors.backgroundColor,
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Type your message',
              hintStyle: const TextStyle(color: AppColors.greyColor),
              filled: true,
              fillColor: AppColors.backgroundColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onSend,
          child: const CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.backgroundColor,
            child: Icon(Icons.send, color: AppColors.greyColor,),
          ),
        ),
      ],
    ),
  );
}

Widget buildUserStatus(String userId) {
  return StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData || snapshot.data!.data() == null) {
        return const Row(
          children: [
            Icon(Icons.circle, color: Colors.white, size: 10),
            SizedBox(width: 5),
            Text('Offline', style: TextStyle(color: Colors.white),),
          ],
        );
      }

      final data = snapshot.data!.data() as Map<String, dynamic>;
      final isOnline = data['online'] ?? false;

      return Row(
        children: [
          Icon(
            Icons.circle,
            color: isOnline ? Colors.green : Colors.red,
            size: 10,
          ),
          const SizedBox(width: 5),
          Text(isOnline ? 'Online' : 'Offline', style: const TextStyle(color: Colors.white),),
        ],
      );
    },
  );
}

Widget buildTypingIndicator(String receiverId) {
  return StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance.collection('users').doc(receiverId).snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData || snapshot.data!.data() == null) {
        return const SizedBox();
      }

      final data = snapshot.data!.data() as Map<String, dynamic>;
      final isTyping = data['typing'] ?? false;

      if (isTyping) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          child: Text(
            "Typing...",
            style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
          ),
        );
      }

      return const SizedBox();
    },
  );
}

