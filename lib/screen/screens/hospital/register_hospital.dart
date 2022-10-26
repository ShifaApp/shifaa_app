import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shifa_app_flutter/const/const.dart';
import 'package:shifa_app_flutter/design/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shifa_app_flutter/models/Hospitals.dart';
import 'package:shifa_app_flutter/screen/screens/hospital/register_doctor.dart';

import '../../../const/route_constants.dart';
import '../../../dialogs/message_dialog.dart';
import '../../../dialogs/progress_dialog.dart';
import '../../../helpers/info_helper.dart';
import '../../../helpers/route_helper.dart';
import '../../widget/app_bar_design.dart';
import '../../widget/buttons_class.dart';
import '../../widget/text_field_class.dart';

class RegisterHospital extends StatefulWidget {
  const RegisterHospital({Key? key}) : super(key: key);

  @override
  State<RegisterHospital> createState() => _RegisterHospitalState();
}

class _RegisterHospitalState extends State<RegisterHospital> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isBtnEnabled = true;
  XFile? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBarWithBck('Register Hospital'),
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.primaryWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [


                ////////////////////////////

                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image
                        await picker
                            .pickImage(source: ImageSource.gallery)
                            .then((value) {
                          setState(() {
                            pickedImage = value;

                            print(pickedImage!.name);
                          });
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 6,
                        decoration: BoxDecoration(
                            color: CustomColors.primaryWhiteColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: pickedImage != null
                                ? Image.file(
                                    File(pickedImage!.path),
                                  )
                                : CircleAvatar(
                                    child: Icon(
                                      Icons.image,
                                      color: CustomColors.primaryWhiteColor,
                                      size: 30,
                                    ),
                                  )),
                      ),
                    ),
                    textFieldStyle(
                        context: context,
                        edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                        lbTxt: 'Hospital Name',
                        textInputType: TextInputType.name,
                        controller: nameController,
                        textInputAction: TextInputAction.next),
                    textFieldStyle(
                        context: context,
                        edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                        lbTxt: 'Hospital Phone',
                        textInputType: TextInputType.phone,
                        controller: phoneController,
                        textInputAction: TextInputAction.next),
                    textFieldStyle(
                        context: context,
                        edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                        lbTxt: 'Hospital Address',
                        textInputType: TextInputType.text,
                        controller: addressController,
                        textInputAction: TextInputAction.next),
                    textFieldStyle(
                        context: context,
                        edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                        lbTxt: 'Hospital Email',
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next),
                    textFieldStyle(
                        context: context,
                        edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                        lbTxt: 'Hospital Password',
                        controller: passController,
                        textInputType: TextInputType.visiblePassword,
                        obscTxt: true,
                        textInputAction: TextInputAction.done),
                    lightBlueBtn(
                        'Continue', const EdgeInsets.only(bottom: 10, top: 10),
                        () {
                      continueSignUp();

                      //
                    }),
                  ],
                ),
                const SizedBox(
                  height: 50,
                )
                //////////////////////////////////////////
                ,
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already Have an Account ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CustomColors.lightBlueColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Log In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CustomColors.lightBlueColor,
                          fontSize: 14,
                        ),
                      )
                      ///////////////
                      ,
                    ],
                  ),
                  onTap: () {
                    moveToNewStack(context, loginRoute);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void continueSignUp() async {
    if (nameController.value.text == '') {
      // print('owner name');

      showErrorMessageDialog(context, 'Please Enter Hospital Name');

      return;
    }

    if (phoneController.value.text == '') {
      // print('owner name');

      showErrorMessageDialog(context, 'Please Enter Hospital Phone');

      return;
    }

    if (addressController.value.text == '') {
      // print('owner name');

      showErrorMessageDialog(context, 'Please Enter Hospital Address');

      return;
    }
    if (emailController.value.text == '') {
      showErrorMessageDialog(context, 'Please Enter Hospital Email');

      return;
    }

    if (isValidEmail(emailController.value.text) == false) {
      showErrorMessageDialog(context, 'Email not Valid');

      return;
    }

    if (passController.value.text == '') {
      showErrorMessageDialog(context, 'Please Enter Hospital Password');

      return;
    }
    if (passController.value.text.length < 6) {
      showErrorMessageDialog(context, 'Password must be more than 6 numbers ');

      return;
    }

    if (pickedImage == null) {
      showErrorMessageDialog(context, 'Please Pick Hospital Image');

      return;
    }
    isBtnEnabled = false;
    //----------show progress----------------
    String imageUrl = '';
    showLoaderDialog(context);
    FocusScope.of(context).unfocus();
    try {
      // register in auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.value.text,
              password: passController.value.text);

      //save image in storage
      var storageRef = FirebaseStorage.instance.ref().child("images");
      storageRef.putFile(File(pickedImage!.path)).whenComplete(() async {
        var url = await storageRef.getDownloadURL();
        imageUrl = url.toString();
      }).catchError((onError) {
        print(onError);
      });
      // save data in database
      DatabaseReference ref =
          FirebaseDatabase.instance.reference().child(hospitals);

      ref
          .child(userCredential.user!.uid)
          .set(Hospitals(
                  image: imageUrl,
                  email: emailController.value.text,
                  name: nameController.value.text,
                  address: addressController.value.text,
                  phone: phoneController.value.text)
              .toMap())
          .then((value) {
        moveToNewStack(context, hospitalDashBoardRoute);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
