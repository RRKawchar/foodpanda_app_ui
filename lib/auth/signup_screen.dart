import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_podpanda_app/consts/app_colors.dart';
import 'package:my_podpanda_app/main_screen/home_screen.dart';
import 'package:my_podpanda_app/widgets/custom_textField.dart';
import 'package:my_podpanda_app/widgets/error_dialog.dart';
import 'package:my_podpanda_app/widgets/loading_dialog.dart';
import 'package:my_podpanda_app/widgets/reusable_text.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();


  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController locationController=TextEditingController();

  XFile? imageXFile;
  final ImagePicker _imagePicker=ImagePicker();

  String completeAddress="";
  String sellerImageUrl="";


  Position? position;
  List<Placemark>? placemarks;

  Future<void> _getImage()async{


   imageXFile=await _imagePicker.pickImage(source: ImageSource.gallery);
   setState(() {

     imageXFile;
   });

  }

  getCurrentLocation()async{
    Position newPosition=await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    // ignore: unrelated_type_equality_checks
    position=newPosition;
     placemarks=await placemarkFromCoordinates(

       position!.latitude,
       position!.longitude
     );
     Placemark pMark=placemarks![0];

     completeAddress='${pMark.subAdministrativeArea},${pMark.thoroughfare},'

         '${pMark.subLocality},${pMark.locality},${pMark.subAdministrativeArea},${pMark.administrativeArea},${pMark.postalCode},${pMark.country}';
     locationController.text=completeAddress;
  }

  Future<void> formValidation()async{

    if(imageXFile==null){

      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "Please select an image.",
            );
          }
      );
    }else{

      if(passwordController.text==confirmPasswordController.text){
        ///
         if(nameController.text.isNotEmpty && emailController.text.isNotEmpty &&
             passwordController.text.isNotEmpty &&
             confirmPasswordController.text.isNotEmpty && phoneController.text.isNotEmpty && locationController.text.isNotEmpty){
            ///start uploading

            showDialog(
                context: context,
                builder: (c){
                  return LoadingDialog(
                    message: "Registering Account",
                  );
                }
            );

            String fileName=DateTime.now().millisecondsSinceEpoch.toString();
            fStorage.Reference reference=fStorage.FirebaseStorage.instance.ref().child("sellers").child(fileName);
            fStorage.UploadTask uploadTask=reference.putFile(File(imageXFile!.path));
            fStorage.TaskSnapshot taskSnapshot=await uploadTask.whenComplete((){});
            await taskSnapshot.ref.getDownloadURL().then((url) {
              sellerImageUrl=url;
            });

            authenticateSellerAndSignUp();


         }else{
           showDialog(
               context: context,
               builder: (c){
                 return ErrorDialog(
                   message: "Please write the complete required info for sign up !",
                 );
               }
           );

         }

      }else{
        showDialog(
            context: context,
            builder: (c){
              return ErrorDialog(
                message: "Password do not match",
              );
            }
        );
      }
    }
  }

  void authenticateSellerAndSignUp()async{

    User?currentUser;
    final FirebaseAuth firebaseAuth=FirebaseAuth.instance;

    await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
    ).then((auth){

    currentUser=auth.user;
    });

    if(currentUser!=null){
      saveDataToFirestore(currentUser!).then((value){
      Navigator.pop(context);

      Route newRoute=MaterialPageRoute(builder: (c)=>HomeScreen());
      Navigator.pushReplacement(context, newRoute);
      });
    }

  }

   Future saveDataToFirestore(User currentUser)async{
  FirebaseFirestore.instance.collection("sellers").doc(currentUser.uid).set({
    'sellersUID':currentUser.uid,
    'sellersEmail':currentUser.email,
    'sellerName':nameController.text.trim(),
    'sellersAvatarUrl':sellerImageUrl,
    'phone':phoneController.text.trim(),
    'address':completeAddress,
    'status':"approved",
    'earnings':0.0,
    'lat':position!.latitude,
    'lng':position!.longitude

  });

   }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                _getImage();
              },
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
                            // _determinePosition();
                            getCurrentLocation();
                            // print("clicked");

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
                          formValidation();
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
