import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_podpanda_app/auth/auth_screen.dart';
import 'package:my_podpanda_app/consts/app_colors.dart';
import 'package:my_podpanda_app/utils/app_images.dart';
import 'package:my_podpanda_app/widgets/reusable_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  startTimer(){
    Timer(const Duration(seconds: 5), ()async {

      Navigator.push(context, MaterialPageRoute(builder: (_)=>const AuthScreen()));

    });
  }

  @override
  void initState() {
  startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: whiteColor,
        child: Center(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
             Image.asset(AppImages.splashImage),
              const SizedBox(height: 10,),
              Padding(
                padding:const EdgeInsets.all(10.0),
                child: ReusableText(text: "Sell Food Online",size: 40,fontFamily: "Signatra",color: black54,textAlign: TextAlign.center,letterSpacing: 3,),

              ),
             const CircularProgressIndicator(
                color: progressColor
              )
            ],
          ),
        ),
      ),
    );
  }
}
