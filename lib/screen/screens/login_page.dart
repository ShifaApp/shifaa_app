import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/const/const.dart';
import 'package:shifa_app_flutter/design/color.dart';
import 'package:shifa_app_flutter/models/user.dart';
import 'package:shifa_app_flutter/screen/screens/dashboard_page.dart';
import 'package:shifa_app_flutter/screen/screens/hospital/hospital_dashboard.dart';
import 'package:shifa_app_flutter/screen/screens/hospital/register_hospital.dart';
import 'package:shifa_app_flutter/screen/screens/signup_page.dart';

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
import 'doctor/doctor_dashboard.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isBtnEnabled = true;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  String? userId;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: CustomColors.primaryWhiteColor,
          body: SafeArea(
              child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: CustomColors.lightBlueColor,
                  // centerTitle: true,
                  // title: Text('Log IN',style: TextStyle(color: CustomColors.primaryWhiteColor,fontSize: 20)),
                  pinned: true,
                  floating: true,

                  bottom: TabBar(
                    indicatorColor: CustomColors.primaryWhiteColor,
                    indicatorWeight: 2,
                    isScrollable: true,
                    tabs: [
                      Tab(
                          child: Text(
                        'Patient',
                        style: TextStyle(
                            color: CustomColors.primaryWhiteColor,
                            fontSize: 20),
                      )),
                      Tab(
                          child: Text('Hospital',
                              style: TextStyle(
                                  color: CustomColors.primaryWhiteColor,
                                  fontSize: 20))),
                      Tab(
                          child: Text('Doctor',
                              style: TextStyle(
                                  color: CustomColors.primaryWhiteColor,
                                  fontSize: 20))),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                pageDesign((userId) {
                  ref.child(users).child(userId!).get().then((value) {
                    if (value.exists) {
                      print(value.value);
                      Const.userName = MyUser.fromJson(value.value).name ?? ' ';
                      moveToNewStackWithArgs(context,
                          MaterialPageRoute(builder: (context) {
                        return const DashboardPage();
                      }));
                    }
                  });
                }, userType: users),
                pageDesign((userId) {
                  ref.child(hospitals).child(userId!).get().then((value) {
                    if (value.exists) {
                      print(value.value);

                      moveToNewStackWithArgs(context,
                          MaterialPageRoute(builder: (context) {
                        return const HospitalDashboard();
                      }));
                    }
                  });
                }, userType: hospitals),
                pageDesign((userId) {
                  ref.child(doctors).child(userId!).get().then((value) {
                    if (value.exists) {
                      print(value.value);

                      moveToNewStackWithArgs(context,
                          MaterialPageRoute(builder: (context) {
                        return const DoctorDashboard();
                      }));
                    }
                  });
                }, userType: doctors),
              ],
            ),
          ))),
    );
  }

  pageDesign(action, {userType = hospitals}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  textInputAction: TextInputAction.done),
              lightBlueBtn('Log In', const EdgeInsets.only(bottom: 10, top: 10),
                  () {
                continueLogin(action);
              }),
              if (userType == hospitals || userType == users)
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
                    ],
                  ),
                  onTap: () {
                    if (userType == users) {
                      //  moveToNewStack(context, signupRoute);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignUpPage();
                      }));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const RegisterHospital();
                      }));
                    }
                  },
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Continue as Guest",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CustomColors.lightBlueColor,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      ///////////////
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const DashboardPage();
                    }));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void continueLogin(Function(String value) action) async {
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
      registerInAuth().then((value) {
        action(value);
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

  Future<String> registerInAuth() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.value.text,
            password: passController.value.text);

    Const.currentUserId = userCredential.user!.uid;
    Const.isUserGuest = false;

    return userCredential.user!.uid;
    // setState(() {
    //   userId = userCredential.user!.uid;
    // });
  }
}
