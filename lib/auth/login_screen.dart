import 'package:flutter/material.dart';
import 'package:my_podpanda_app/consts/app_colors.dart';
import 'package:my_podpanda_app/widgets/custom_textField.dart';
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
                      print("Clicked");
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
