import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/design/color.dart';

import '../../const/const.dart';
import '../../const/route_constants.dart';
import '../../dialogs/message_dialog.dart';
import '../../dialogs/progress_dialog.dart';
import '../../helpers/info_helper.dart';
import '../../helpers/route_helper.dart';
import '../../models/user.dart';
import '../widget/buttons_class.dart';
import '../widget/text_field_class.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isBtnEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      // backgroundColor: CustomColors.lightBlueColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Create account'.toUpperCase(),
                textAlign: TextAlign.center,
                style:  TextStyle(
                  color:  CustomColors.lightBlueColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),

              ////////////////////////////

              Column(
                children: [
                  textFieldStyle(
                      context: context,
                      edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                      lbTxt: 'Your Name',
                      textInputType: TextInputType.name,
                      controller: nameController,
                      textInputAction: TextInputAction.next),
                  textFieldStyle(
                      context: context,
                      edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                      lbTxt: 'Your Email',
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next),
                  textFieldStyle(
                      context: context,
                      edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                      lbTxt: 'Your Password',
                      controller: passController,
                      textInputType: TextInputType.visiblePassword,
                      obscTxt: true,
                      textInputAction: TextInputAction.done),
                  lightBlueBtn('Sign Up',
                      const EdgeInsets.only(bottom: 10, top: 10), () {
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
                  children:  [
                    Text(
                      'Already Have an Account ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:  CustomColors.lightBlueColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Log In',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:  CustomColors.lightBlueColor,
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
    );
  }

  void continueSignUp() async{
    if (nameController.value.text == '') {
      // print('owner name');

      showErrorMessageDialog(context, 'Please Enter your Name');

      return;
    }

    if (emailController.value.text == '') {
      showErrorMessageDialog(context,'Please Enter your Email');

      return;
    }

    if (isValidEmail(emailController.value.text) == false) {
      showErrorMessageDialog(context, 'Email not Valid');

      return;
    }

    if (passController.value.text == '') {
      showErrorMessageDialog(context,'Please Enter your Password');

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
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.value.text,
          password:  passController.value.text
      );
      DatabaseReference ref = FirebaseDatabase.instance.reference().child(users);


       ref.child(userCredential.user!.uid).set(MyUser(email:emailController.value.text,name: nameController.value.text, ).toMap()).then((value){
        moveToNewStack(context, dashBoardRoute);
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
