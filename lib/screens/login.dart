import 'dart:ffi';

import 'package:email_validator/email_validator.dart';

import 'package:firebase_app/screens/home.dart';
import 'package:firebase_app/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../controller.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin{
  var _key = GlobalKey<FormState>();
  var c = Get.put(UserController());
  late AnimationController _controller;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visible = false ;
  var icon = Icon(Icons.visibility);
  @override
  void initState() {
    _controller =AnimationController(vsync: this );
    c.onInit();
    super.initState();
  }
  @override
  void dispose() {
    _controller;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:Form(
          key: _key,
          child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 200,
                        width: 200,
                        child: Lottie.asset('assets/welcome.json',
                            controller: _controller ,
                            onLoaded: (compose){
                              _controller
                                ..duration;
                            }),
                      ),
                      Text('Log in' ,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber
                        ),),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          } else if (!(value.contains('@') && value.contains('.'))) {
                            return 'email must contain "@" , "."';
                          }
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: Icon(Icons.email, color: Colors.black,),
                          labelText: 'Enter your username',
                          labelStyle: TextStyle(
                              color: Colors.amber
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: !visible,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          } else if (value.length < 6) {
                            return 'password must be more than 6 letters ';
                          }
                        },
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            color: Colors.black,
                            onPressed: (){
                              setState(() {
                                visible = !visible ;
                                if(visible){
                                  icon = Icon(Icons.visibility_off);}
                                else icon = Icon(Icons.visibility);
                              });
                            },
                            icon: icon,),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)
                          ),
                          prefixIcon: Icon(Icons.password , color: Colors.black,),
                          labelText: 'Enter your password',
                          labelStyle: TextStyle(
                              color: Colors.amber
                          ) ,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.amber) ,
                              elevation:  MaterialStateProperty.all(5),
                              shape: MaterialStateProperty.all(StadiumBorder())
                          ),
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              c.loginUser(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }

                            },
                            child: Text('Sign in ',
                            style: TextStyle(
                            fontSize: 18
                            )
                            ,)
                            ),
                            SizedBox(
                            height: 5,
                            ),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Text(
                            "don't have email ? ,",
                            style: TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                                onTap: () {
                                  Get.to( Register() , transition: Transition.cupertino);
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(fontSize: 17,
                                      color: Colors.amber),
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text('OR' ,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey
                        ) ,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.all(8),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(color: Colors.amber)
                              )

                          ),
                          onPressed: (){
                            // c.signInWithGoogle();
                            c.signInWithGoogle();
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Text('Sign up with google' ,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.amber
                                  ),),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset('assets/Google.png'),
                                )
                              ]
                          )
                      ),

                    ],
                  ),
                ),
              ),
        )
      ),
    );
  }
}
