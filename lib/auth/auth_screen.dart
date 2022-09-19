import 'package:flutter/material.dart';
import 'package:my_podpanda_app/auth/login_screen.dart';
import 'package:my_podpanda_app/auth/signup_screen.dart';
import 'package:my_podpanda_app/consts/app_colors.dart';
import 'package:my_podpanda_app/widgets/reusable_text.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration:  BoxDecoration(
                gradient: LinearGradient(
                    colors: [pinkAccent.withOpacity(0.8),amberAccent.withOpacity(0.8),],
                    begin:const FractionalOffset(0.0, 0.0),
                    end:const FractionalOffset(1.0, 0.0),
                    stops:const [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            title: ReusableText(
              text: "iFood",
              size: 60,
              color: whiteColor,
              fontFamily: "Lobster",
            ),
            centerTitle: true,
            bottom:const TabBar(
              indicatorColor: indicatorColor ,
              indicatorWeight: 6,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.lock,
                    color: whiteColor,


                  ),
                  text: "Login",
                ),
                Tab(
                  icon: Icon(
                    Icons.person,
                    color: whiteColor,
                  ),
                  text: "LogOut",
                ),
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [amberAccent.withOpacity(0.8),pinkAccent.withOpacity(0.8)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              )
            ),
            child:const TabBarView(
              children: [
                LoginScreen(),
                SignUpScreen()
              ],
            ),
          ),
        ));
  }
}
