



import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource {
  //ToDo: LoginWebServices Function

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<UserCredential> login(
      {required String email,
        required String password,
      })async{

    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "email": email,
        "uid": userCredential.user!.uid
      });
      return userCredential;
    }

    on FirebaseAuthException catch(e){
      throw Exception(e.code);
      }
    }


    ///logout

  Future<void> logout()async{
    return await _auth.signOut();
  }


  // ToDo Register Function
  Future<UserCredential> register({
    required String password,
    required String email,

  }) async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password
      );
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "email": email,
        "uid": userCredential.user!.uid
      });
      return userCredential;
    }
    on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

}
