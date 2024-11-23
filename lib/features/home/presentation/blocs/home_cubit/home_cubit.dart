import 'dart:async';

import 'package:altaqwaa_new/features/home/data/repositories/home_repository.dart';
import 'package:altaqwaa_new/features/home/models/message_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeRepo _homeRepo;

  HomeCubit(this._homeRepo) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  ///get users


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  ///get users
  Stream<List<Map<String, dynamic>>> getUsers() {
      return   _firestore.collection("Users").snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          final user = doc.data();
          return user;
        }).toList();
      });
  }


  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    DateTime dateTime = timestamp.toDate();
    String formattedTime = DateFormat('h:mm:ss a').format(dateTime);

    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: formattedTime
    );
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }


  ///get messages

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String userId,
      String otherUserId) {
    {
      List<String> ids = [userId, otherUserId];
      ids.sort();
      String chatRoomId = ids.join('_');
      return _firestore
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots();
    }
  }


  ///online status

  Future<void> setOnlineStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final userRef = _firestore.collection('users').doc(user.uid);
      final connectionRef =
      FirebaseDatabase.instance.ref(".info/connected");

      connectionRef.onValue.listen((event) async {
        final isConnected = event.snapshot.value as bool? ?? false;

        if (isConnected) {
          await userRef.update({"online": true});
        } else {
          await userRef.update({
            "online": false,
            "lastSeen": DateTime.now().toIso8601String(),
          });
        }
      });
    }
  }


  ///typing status

  Future<void> setTypingStatus(bool isTyping, String receiverId) async {
    final user = _auth.currentUser;

    if (user != null) {
      await _firestore
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(user.uid)
          .set({"typing": isTyping}, SetOptions(merge: true));
    }
  }

}
