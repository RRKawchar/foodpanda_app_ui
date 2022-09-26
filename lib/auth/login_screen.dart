import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_podpanda_app/consts/app_colors.dart';
import 'package:my_podpanda_app/global/global.dart';
import 'package:my_podpanda_app/main_screen/home_screen.dart';
import 'package:my_podpanda_app/widgets/custom_textField.dart';
import 'package:my_podpanda_app/widgets/error_dialog.dart';
import 'package:my_podpanda_app/widgets/loading_dialog.dart';
import 'package:my_podpanda_app/widgets/reusable_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  formValidation(){

    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
    loginNow();

    }else{

      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "Please write Email/Password!",
            );
          }
      );
    }
  }

  loginNow()async{

    showDialog(
        context: context,
        builder: (c){
          return LoadingDialog(
            message: "Checking credentials",
          );
        }
    );


    User?currentUser;

    await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
    ).then((auth){

      currentUser=auth.user!;
    }).catchError((error){
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message:error.message.toString(),
            );
          }
      );


    });

    if(currentUser!=null){
      readAndSetDataLocally(currentUser!).then((value){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c)=>const HomeScreen()));
      });
    }
  }
  Future readAndSetDataLocally(User currentUser)async{
    await FirebaseFirestore.instance.collection("sellers").doc(currentUser.uid).get().then((snapshot)async{

      await sharedPreferences!.setString("uid", currentUser.uid);
      await sharedPreferences!.setString("email", snapshot.data()!['sellersEmail']);
      await sharedPreferences!.setString("name", snapshot.data()!['sellerName']);
      await sharedPreferences!.setString("photoUrl", snapshot.data()!['sellersAvatarUrl']);

    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                "assets/images/seller.png",
                height: 270,
              ),
            ),
          ),
          Form(
            key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    icon: Icons.email,
                    controller: emailController,
                    hintText: "Email",
                    isObscure: false,
                  ),
                  CustomTextField(
                    icon: Icons.lock,
                    controller: passwordController,
                    hintText: "Password",
                    isObscure: true,
                  ),
                  ElevatedButton(

                    onPressed: (){
                     formValidation();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: cyanColor,
                        padding:const EdgeInsets.symmetric(horizontal: 50,vertical: 10)
                    ),
                    child: ReusableText(text: "Login",color: whiteColor,fontWeight: FontWeight.bold,),
                  ),
                  const SizedBox(height: 30,),
                ],
              )
          )
        ],
      ),
    );
  }
}
