import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/components/resuable_component.dart';
import 'package:firebase_app/controller.dart';
import 'package:firebase_app/screens/login.dart';
import 'package:firebase_app/screens/sms_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var c = Get.put(UserController());
  var _key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  bool visible = false ;
  var icon = Icon(Icons.visibility,color: Colors.black,);
  bool visible1 = false ;
  var icon1 = Icon(Icons.visibility,color: Colors.black,);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Form(
        key: _key,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListView(
                  padding:EdgeInsets.fromLTRB(0, 100, 0, 0) ,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [ Container(
                  padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                     height: 80,
                      width: 80,
                 child: Image.asset('assets/logo.png'),
          ),
                  Container(
                  padding: EdgeInsets.all(18),
                  height: 520,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 208, 165, 91),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Register :)',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      customTextField(
                        validator: (value){
                          if (value!.isEmpty) {
                            return 'Required';
                          }
                        },
                        labelText: 'Enter Your name',
                          controller: nameController,
                          icon: Icons.contact_mail,),
                      SizedBox(
                        height: 15,
                      ),

                      customTextField(
                        type: TextInputType.phone,
                          validator: (value){
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                          },
                          labelText: 'Enter your phone number',
                          controller: phoneController,
                          icon: Icons.phone),
                      SizedBox(
                        height: 15,
                      ),
                      customTextField(
                        type: TextInputType.emailAddress,
                        labelText: 'Email Address',
                          validator: (value){
                            if (value!.isEmpty) {
                              return 'Required';
                            } else if (!(value.contains('@') &&
                                value.contains('.'))) {
                              return 'email must contain "@" , "."';
                            }
                          },
                          controller: emailController,
                          icon: Icons.mail),
                      SizedBox(
                        height: 15,
                      ),
                      customTextField(
                          iconButton: IconButton(onPressed: (){
                            setState(() {
                              visible = !visible ;
                              if(visible){
                                icon = Icon(Icons.visibility_off,color: Colors.black,);}
                              else icon = Icon(Icons.visibility, color: Colors.black,);
                            });
                          },
                              icon:icon),
                          obscureText: !visible,
                          validator: (value){
                            if (value!.isEmpty) {
                              return 'Required';
                            } else if (value.length < 6) {
                              return 'password must be more than 6 letters ';
                            }
                          },
                          labelText: 'Enter your password',
                          controller: passwordController,
                          icon: Icons.password),
                      SizedBox(
                        height: 15,
                      ),
                      customTextField(
                        obscureText: !visible1,
                        iconButton: IconButton(onPressed: (){
                          setState(() {
                            visible1 = !visible1 ;
                            if(visible1){
                              icon1 = Icon(Icons.visibility_off ,color: Colors.black,);}
                            else icon1 = Icon(Icons.visibility, color: Colors.black,);
                          });
                        },
                            icon:icon1),
                          labelText: 'Renter your password ',
                          validator: (value){
                            if (passwordController.text != confirmController.text) {
                              return "don't match";
                            }
                          },
                          controller: confirmController,
                          icon: Icons.password),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                            ),
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                setState(()  {
                                   c.createUser(
                                     phone: phoneController.text,
                                     name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text);

                                });
                              }
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                        ),
                      )
                    ],
                      ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      )),
    );
  }
}
