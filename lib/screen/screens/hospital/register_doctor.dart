import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shifa_app_flutter/const/const.dart';
import 'package:shifa_app_flutter/const/route_constants.dart';
import 'package:shifa_app_flutter/design/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shifa_app_flutter/dialogs/snack_message.dart';
import 'package:shifa_app_flutter/helpers/route_helper.dart';
import 'package:shifa_app_flutter/models/Doctors.dart';
import 'package:shifa_app_flutter/models/Hospitals.dart';
import 'package:shifa_app_flutter/screen/widget/app_bar_design.dart';

import '../../../dialogs/message_dialog.dart';
import '../../../dialogs/progress_dialog.dart';
import '../../../helpers/info_helper.dart';
import '../../widget/buttons_class.dart';
import '../../widget/text_field_class.dart';
import 'hospital_dashboard.dart';

class RegisterDoctor extends StatefulWidget {
  const RegisterDoctor({Key? key}) : super(key: key);

  @override
  State<RegisterDoctor> createState() => _RegisterDoctorState();
}

class _RegisterDoctorState extends State<RegisterDoctor> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController feesController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController majorController = TextEditingController();

  bool isBtnEnabled = true;
  XFile? pickedImage;
  late Hospitals? hospital;
  String hospitalName = '',hospitalId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DatabaseReference ref =
        FirebaseDatabase.instance.reference().child(hospitals);

    ref.child(Const.currentUserId).get().then((h) {
      if (h.exists) {
        hospital = Hospitals.fromJson(h.value);
        setState(() {
          hospitalName = hospital!.name!;
          hospitalId = hospital!.hospitalId!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBarWithBck('Add Doctor'),
      resizeToAvoidBottomInset: true,
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
                          if (value != null) {
                            setState(() {
                              pickedImage = value;

                              print(pickedImage!.name);
                            });
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 7,
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
                        lbTxt: ' Name',
                        textInputType: TextInputType.name,
                        controller: nameController,
                        textInputAction: TextInputAction.next),
                    textFieldStyle(
                        context: context,
                        edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                        lbTxt: 'Specialist',
                        textInputType: TextInputType.text,
                        controller: majorController,
                        textInputAction: TextInputAction.next),
                    textFieldStyle(
                        context: context,
                        edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                        lbTxt: ' Phone',
                        textInputType: TextInputType.phone,
                        controller: phoneController,
                        textInputAction: TextInputAction.next),
                    textFieldStyle(
                        context: context,
                        edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                        lbTxt: ' Fess',
                        textInputType: TextInputType.number,
                        controller: feesController,
                        textInputAction: TextInputAction.next),
                    textFieldStyle(
                        context: context,
                        edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                        lbTxt: ' Email',
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next),
                    textFieldStyle(
                        context: context,
                        edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                        lbTxt: ' Password',
                        controller: passController,
                        textInputType: TextInputType.visiblePassword,
                        obscTxt: true,
                        textInputAction: TextInputAction.done),
                    lightBlueBtn('Add Doctor',
                        const EdgeInsets.only(bottom: 10, top: 10), () {
                      continueSignUp();

                      //
                    }),
                  ],
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

      showErrorMessageDialog(context, 'Please Enter doctor Name');

      return;
    }

    if (phoneController.value.text == '') {
      // print('owner name');

      showErrorMessageDialog(context, 'Please Enter doctor Phone');

      return;
    }

    if (feesController.value.text == '') {
      // print('owner name');

      showErrorMessageDialog(context, 'Please Enter doctor Fees');

      return;
    }

    if (majorController.value.text == '') {
      // print('owner name');

      showErrorMessageDialog(context, 'Please Enter doctor specialist');

      return;
    }
    if (emailController.value.text == '') {
      showErrorMessageDialog(context, 'Please Enter doctor Email');

      return;
    }

    if (isValidEmail(emailController.value.text) == false) {
      showErrorMessageDialog(context, 'Email not Valid');

      return;
    }

    if (passController.value.text == '') {
      showErrorMessageDialog(context, 'Please Enter doctor Password');

      return;
    }
    if (passController.value.text.length < 6) {
      showErrorMessageDialog(context, 'Password must be more than 6 numbers ');

      return;
    }
    if (pickedImage == null) {
      showErrorMessageDialog(context, 'Please Pick Doctor Image');

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
      var storageRef = FirebaseStorage.instance.ref().child("images").child(pickedImage!.path);
      storageRef.putFile(File(pickedImage!.path)).whenComplete(() async {
        var url = await storageRef.getDownloadURL();
        imageUrl = url.toString();

        DatabaseReference ref = FirebaseDatabase.instance
            .ref()
             .child(hospitals)
             .child(Const.currentUserId)
            .child(doctors);//.child(userCredential.user!.uid);
        String? newkey = userCredential.user!.uid;
        ref.child(newkey).set(Doctors(
                    image: imageUrl,
                    id:newkey,
                    hospitalId:Const.currentUserId,
                    email: emailController.value.text,
                    name: nameController.value.text,
                    hospitalName:hospitalName,
                    fees: feesController.value.text,
                    specialist: majorController.value.text,
                    phone: phoneController.value.text)
                .toMap())
            .then((value) {
          showSuccessMessage(context, 'Doctor Added Successfully');
          moveToNewStackWithArgs(context, MaterialPageRoute(builder: (context) {
            return const HospitalDashboard();
          }));
        }).catchError((onError) {
          print(onError);
        });
        // save data in database
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Navigator.pop(context);

        showSuccessMessage(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Navigator.pop(context);

        showSuccessMessage(
            context, 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
