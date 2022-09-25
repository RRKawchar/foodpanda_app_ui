import 'package:flutter/material.dart';
import 'package:my_podpanda_app/consts/app_colors.dart';

class ErrorDialog extends StatelessWidget {
 final String? message;
  ErrorDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
     key: key,
     content: Text(message!),

     actions: [
      ElevatedButton(
          onPressed: (){
           Navigator.pop(context);
          },
          child: const Center(
           child: Text("OK"),
          ),
       style: ElevatedButton.styleFrom(
        backgroundColor: redColor
       ),
      )
     ],
    );
  }
}
