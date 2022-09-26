import 'package:flutter/material.dart';
import 'package:my_podpanda_app/auth/auth_screen.dart';
import 'package:my_podpanda_app/consts/app_colors.dart';
import 'package:my_podpanda_app/global/global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text(
              sharedPreferences!.getString("name")!,

            ),
           centerTitle: true,
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
           automaticallyImplyLeading: false,
          ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: amberColor
          ),
          onPressed: (){
            firebaseAuth.signOut().then((value){

              Navigator.push(context, MaterialPageRoute(builder: (_)=>const AuthScreen()));
            });

          },
          child: Text("LogOut"),
        ),
      ),
    );
  }
}
