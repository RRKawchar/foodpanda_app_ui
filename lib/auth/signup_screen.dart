import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_podpanda_app/consts/app_colors.dart';
import 'package:my_podpanda_app/widgets/custom_textField.dart';
import 'package:my_podpanda_app/widgets/reusable_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  XFile? imageXFile;
  final ImagePicker _imagePicker=ImagePicker();

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController locationController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 10,),
            InkWell(
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width*0.20,
                backgroundColor:whiteColor,
                backgroundImage: imageXFile==null?null:FileImage(File(imageXFile!.path)),
                child: imageXFile==null?
                Icon(
                  Icons.add_photo_alternate,
                size: MediaQuery.of(context).size.width*0.20,
                color:Colors.grey ,
                ):null,
              ),
            ),
            const SizedBox(height: 10,),
            Form(
              key: _formKey,

                child: Column(
                  children: [
                    CustomTextField(
                      icon: Icons.person,
                       controller: nameController,
                       hintText: "Name",
                      isObscure: false,
                    ),
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
                    CustomTextField(
                      icon: Icons.lock,
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      isObscure: true,
                    ),
                    CustomTextField(
                      icon: Icons.phone,
                      controller: phoneController,
                      hintText: "Phone",
                      isObscure: false,
                    ),
                    CustomTextField(
                      icon: Icons.my_location,
                      controller: locationController,
                      hintText: "Cafe/Restaurant Address",
                      isObscure: false,
                      enable: false,
                    ),
                    Container(
                      width: 400,
                      height: 40,
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                          onPressed: (){
                            print("clicked");

                          },
                          icon:const Icon(Icons.location_on,color: whiteColor),
                          label: ReusableText(text: "Get My Current Location",color: whiteColor),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: amberColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                          ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    ElevatedButton(

                        onPressed: (){
                          print("Clicked");
                        },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cyanColor,
                        padding:const EdgeInsets.symmetric(horizontal: 50,vertical: 10)
                      ),
                        child: ReusableText(text: "Sign Up",color: whiteColor,fontWeight: FontWeight.bold,),
                    ),
                    const SizedBox(height: 30,),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
