import 'package:centic_bids/Screens/Auth/Login.dart';
import 'package:centic_bids/Screens/Main/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  bool isLoggedIn;

  Future<bool> signIn(String email, String password) async {
    bool check = true;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      check = false;
    }
    return check;
  }

  Future<bool> signUp(String email, String password, String name) async {
    bool check = true;
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      users.add({'name': name, 'email': email});
    } on FirebaseAuthException catch (e) {
      print(e);
      check = false;
    }
    return check;
  }

  Future<void> forgotPassword(email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout(context) async {
      await _firebaseAuth.signOut();
       Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Login()));
    }
   
}
