import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/screens/login.dart';
import 'package:firebase_app/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp( debugShowCheckedModeBanner: false,
    home: MyApp(),

  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _State();
}

class _State extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Login(),
    );
  }
}
