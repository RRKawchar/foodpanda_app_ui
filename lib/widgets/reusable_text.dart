import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  final String text;
  TextAlign? textAlign;
  double? size;
  FontWeight? fontWeight;
  Color? color;
  String? fontFamily;
  double? letterSpacing;
   ReusableText({Key? key, required this.text,this.color,this.size,this.fontFamily,this.fontWeight,this.letterSpacing,this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,textAlign: textAlign,
      style: TextStyle(fontSize: size,color: color,fontFamily: fontFamily,letterSpacing: letterSpacing),
    );
  }
}
