import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController?  controller;
  final IconData? icon;
  final String? hintText;
  bool? isObscure = false;
  bool? enable=true;

  CustomTextField(
      {Key? key,
      this.controller,
      this.icon,
      this.hintText,
      required this.isObscure,
      this.enable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const BoxDecoration(
       color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),

      ),
      padding:const EdgeInsets.all(8.0),
      margin:const EdgeInsets.all(10.0),
      child: TextFormField(
        enabled: enable,
        controller: controller,
        obscureText: isObscure!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            icon,
            color: Colors.cyan,

          ),
         focusColor: Theme.of(context).primaryColor,
          hintText: hintText
        ),

      ),
    );
  }
}
