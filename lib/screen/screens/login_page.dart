import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/const/const.dart';
import 'package:shifa_app_flutter/design/color.dart';
import 'package:shifa_app_flutter/models/user.dart';
import 'package:shifa_app_flutter/screen/screens/dashboard_page.dart';
import 'package:shifa_app_flutter/screen/screens/hospital/hospital_dashboard.dart';

import '../../const/route_constants.dart';
import '../../dialogs/message_dialog.dart';
import '../../dialogs/progress_dialog.dart';
import '../../dialogs/snack_message.dart';
import '../../helpers/info_helper.dart';
import '../../helpers/route_helper.dart';
import '../../models/Doctors.dart';
import '../../models/Hospitals.dart';
import '../widget/buttons_class.dart';
import '../widget/text_field_class.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isBtnEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.primaryWhiteColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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

              Column(
                children: [
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
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account ? ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CustomColors.lightBlueColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Sign Up',
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
                      moveToNewStack(context, signupRoute);
                    },
                  ),
                ],
              )
         ,

              const SizedBox(
                height: 70,
              )
              //////////////////////////////////////////
              ,
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        moveToNewStack(context, registerHospitalRoute);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Register as Hospital',
                            style: TextStyle(
                                color: CustomColors.lightBlueColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w800)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        moveToNewStack(context, registerHospitalRoute);
                      },
                      child: Text('Log in  as Doctor',
                          style: TextStyle(
                              color: CustomColors.lightBlueColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ),

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

      DatabaseReference ref = FirebaseDatabase.instance.ref();

      ref.child(users).child(userCredential.user!.uid).get().then((value) {
        if (value.exists) {
          print(value.value);

          moveToNewStackWithArgs(context,MaterialPageRoute(builder: (context) {
            return DashboardPage(myUser:  MyUser.fromJson(value.value));
          }));
        } else {
          ref.child(hospitals).child(userCredential.user!.uid);
          ref.get().then((value) {
            if (value.exists) {
              print('Hospital + ${Hospitals.fromJson(value.value)}');
              moveToNewStackWithArgs(context,MaterialPageRoute(builder: (context) {
                return HospitalDashboard(hospitals: Hospitals.fromJson(value.value));
              }));
            }
          });
        }
      });
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
