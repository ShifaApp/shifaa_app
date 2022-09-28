import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/design/color.dart';

import '../../const/route_constants.dart';
import '../../dialogs/message_dialog.dart';
import '../../dialogs/progress_dialog.dart';
import '../../helpers/info_helper.dart';
import '../../helpers/route_helper.dart';
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
      backgroundColor: CustomColors.lightBlueColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Log In'.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800),
              ),

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
                      textInputAction: TextInputAction.done),
                  lightBlueBtn(
                      'Log In', const EdgeInsets.only(bottom: 10, top: 10), () {
                    continueLogin();
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
                  children: const [
                    Text(
                      "Don't have an account ? ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.lightBlue,
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
          ),
        ),
      ),
    );
  }

  void continueLogin() {


    if (emailController.value.text == '') {
      showErrorMessageDialog(context,'Please Enter your Email');

      return;
    }

    if (isValidEmail(emailController.value.text) == false) {
      showErrorMessageDialog(context, S.of(context).email_not_valid);

      return;
    }

    if (passController.value.text == '') {
      showErrorMessageDialog(context,'Please Enter your Password');

      return;
    }
    if (passController.value.text.length < 6) {
      showErrorMessageDialog(context, S.of(context).pass_length);

      return;
    }
    isBtnEnabled = false;
    //----------show progress----------------

    showLoaderDialog(context);
    FocusScope.of(context).unfocus();
  }
}
