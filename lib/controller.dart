
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_app/screens/home.dart';
import 'package:firebase_app/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController extends RxController{


  createUser({
    required String email,
    required String password,
    required String name,
    required String phone})
  async{
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: email,
         password: password).then((value) {
           sendData(name, phone, value.user!.uid);
           Get.snackbar('user created', 'welcome',
           snackPosition: SnackPosition.BOTTOM,
           backgroundColor:Color.fromARGB(255, 248, 216, 119),
           colorText: Colors.black);
           Get.off(Login(), transition: Transition.cupertinoDialog);
     }).catchError((e){
       print(e);
       Get.snackbar('Error', 'invalid email',
           snackPosition: SnackPosition.BOTTOM,
       colorText: Colors.black,
       backgroundColor: Color.fromARGB(255, 255, 102, 91));
     });
  }

  sendData(String name , String phone , String id )
  async{

    await FirebaseFirestore.instance.collection('user').doc('${id}').set({
      'name' : name ,
      'phone': phone
    });
  }

  loginUser({
    required String email,
    required String password,
})
  async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      // value.user!.sendEmailVerification();
      Get.snackbar('success login', 'welcome',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor:Color.fromARGB(255, 248, 216, 119),
          colorText: Colors.black);
      Get.off(Home(), transition: Transition.cupertinoDialog);

    }).catchError((e){
      print(e);
      Get.snackbar('Error', 'Invalid email',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.black,
          backgroundColor: Color.fromARGB(255, 255, 102, 91));

    });
  }

  signInWithGoogle() async{
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      Get.snackbar('success login', 'welcome',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(255, 248, 216, 119),
          colorText: Colors.black);
      Get.off(Home(), transition: Transition.cupertino);
    }).catchError((e) {
      print(e);
      Get.snackbar('Error', 'invalid email',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(255, 255, 102, 91),
          colorText: Colors.black);
    });
  }

  }
