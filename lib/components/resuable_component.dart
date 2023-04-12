
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customTextField({
  TextInputType? type,
  bool obscureText = false,
  IconButton? iconButton,
  String? labelText ,
  @required TextEditingController? controller,
  @required IconData? icon,
   String? validator(String? value)?,
}) => TextFormField(
  obscureText: obscureText ,
  validator: validator,
  controller: controller,
  keyboardType: type,
  decoration: InputDecoration(
    prefixIcon: Icon(icon , color: Colors.black,),
    labelText: labelText,
    labelStyle: TextStyle(color: Colors.black),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black)
    ),
    suffixIcon: iconButton,
  ),
);

