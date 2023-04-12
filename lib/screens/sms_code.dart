import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller.dart';



class Sms extends StatefulWidget {
  const Sms({Key? key}) : super(key: key);

  @override
  State<Sms> createState() => _SmsState();
}

class _SmsState extends State<Sms> {
  TextEditingController smsController = TextEditingController();
  var c = Get.put(UserController());

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('Sms code'),),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: smsController,
                decoration:InputDecoration(
                  labelText: "0000",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ) ,
              ),
              ElevatedButton(onPressed: (){
                setState(() {

                });
              }, child: Text('send'))
            ],
          ),

    ));
  }
}
