import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/models/Doctors.dart';
import 'package:shifa_app_flutter/models/Hospitals.dart';
import 'package:shifa_app_flutter/screen/widget/app_bar_design.dart';

import '../../../const/const.dart';
import '../../../design/color.dart';
import '../../../dialogs/message_dialog.dart';
import '../../../dialogs/progress_dialog.dart';
import '../../../dialogs/snack_message.dart';
import '../../../helpers/info_helper.dart';
import '../../../helpers/route_helper.dart';
import '../../widget/buttons_class.dart';
import '../../widget/text_field_class.dart';
import 'doctor_dashboard.dart';

class LoginDoctor extends StatefulWidget {
  const LoginDoctor({Key? key}) : super(key: key);

  @override
  State<LoginDoctor> createState() => _LoginDoctorState();
}

class _LoginDoctorState extends State<LoginDoctor> {
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isBtnEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.primaryWhiteColor,
      appBar: basicAppBarWithBck('Login Doctor'),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
         //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assests/shifa.png',
                  height: MediaQuery.of(context).size.height / 4,
                ),
              ),
              // Text(
              //   'Log In'.toUpperCase(),
              //   textAlign: TextAlign.center,
              //   style:  TextStyle(
              //       color: CustomColors.lightBlueColor,
              //       fontSize: 28,
              //       fontWeight: FontWeight.w800),
              // ),

              ////////////////////////////

              const SizedBox(
                height: 20,
              ),
              textFieldStyle(
                  context: context,
                  edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                  lbTxt: 'Your Email',
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next),
              textFieldStyle(
                  context: context,
                  controller: passController,
                  edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                  lbTxt: 'Your Password',
                  textInputType: TextInputType.visiblePassword,
                  obscTxt: true,
                  textInputAction: TextInputAction.go),
              lightBlueBtn(
                  'Log In', const EdgeInsets.only(bottom: 10, top: 10), () {
                continueLogin();
              }),
            ],
          ),
        ),
      ),
    );
  }

  void continueLogin() async {
    if (emailController.value.text == '') {
      showErrorMessageDialog(context, 'Please Enter your Email');

      return;
    }

    if (isValidEmail(emailController.value.text) == false) {
      showErrorMessageDialog(context, 'Email not Valid');

      return;
    }

    if (passController.value.text == '') {
      showErrorMessageDialog(context, 'Please Enter your Password');

      return;
    }
    if (passController.value.text.length < 6) {
      showErrorMessageDialog(context, 'Password must be more than 6 numbers ');

      return;
    }
    isBtnEnabled = false;
    //----------show progress----------------

    showLoaderDialog(context);
    FocusScope.of(context).unfocus();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.value.text,
              password: passController.value.text);

      Const.currentUserId = userCredential.user!.uid;
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const DoctorDashboard();
      }));

    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        showSuccessMessage(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSuccessMessage(context, 'Wrong password provided for that user.');
      }
    }
  }
}
