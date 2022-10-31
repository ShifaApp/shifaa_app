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
import '../widget/app_bar_design.dart';
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

  final TextEditingController bloodController = TextEditingController();
  final TextEditingController insuranceController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  List<String> sexList = ['Select Your Sex ', 'Male', 'Female'];
  String? selectedSex;
  bool isBtnEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBarWithBck('Register Patient'),
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.primaryWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assests/shifa.png',
                  height: MediaQuery.of(context).size.height / 4,
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
                        textInputAction: TextInputAction.next),
                    textFieldStyle(
                        context: context,
                        edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                        lbTxt: 'Your Phone',
                        controller: phoneController,
                        enabled: false,
                        textInputType: TextInputType.phone,
                        textInputAction: TextInputAction.next),
                    textFieldStyle(
                        context: context,
                        edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                        lbTxt: 'Your Insurance Id ',
                        controller: insuranceController,
                        enabled: false,
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next),
                    textFieldStyle(
                        context: context,
                        edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                        lbTxt: 'Your Address',
                        controller: addressController,
                        enabled: false,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next),
                    // sex , birth date
                    textFieldStyle(
                        context: context,
                        edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                        lbTxt: 'blood group',
                        controller: bloodController,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.done),
                    textFieldStyle(
                        context: context,
                        readOnly: true,
                        edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                        lbTxt: 'Birth of Date',
                        controller: dateController,
                        textInputType: TextInputType.text,
                        onTap: showPickDate),
                    DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField<String>(
                          value: sexList.first,
                          decoration:
                              const InputDecoration.collapsed(hintText: ''),
                          // icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: TextStyle(
                            color: CustomColors.darkGrayColor,
                          ),
                          onChanged: (String? newValue) {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              selectedSex = newValue!;
                            });
                          },
                          items: sexList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    lightBlueBtn(
                        'Sign Up', const EdgeInsets.only(bottom: 10, top: 10),
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

      showErrorMessageDialog(context, 'Please Enter your Name');

      return;
    }

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
    if (insuranceController.value.text == '') {
      showErrorMessageDialog(context, 'Please Enter your Insurance Id');

      return;
    }
    if (addressController.value.text == '') {
      showErrorMessageDialog(context, 'Please Enter your Address');

      return;
    }
    if (bloodController.value.text == '') {
      showErrorMessageDialog(context, 'Please Enter your Blood Type');

      return;
    }
    if (selectedSex == null) {
      showErrorMessageDialog(context, 'Please Choose your Gender');

      return;
    }
    if (phoneController.value.text == '') {
      showErrorMessageDialog(context, 'Please Enter your Phone');

      return;
    }
    if (dateController.value.text == '') {
      showErrorMessageDialog(context, 'Please Enter your Date Of Birth');

      return;
    }
    isBtnEnabled = false;
    //----------show progress----------------

    showLoaderDialog(context);
    FocusScope.of(context).unfocus();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.value.text,
              password: passController.value.text);
      DatabaseReference ref =
          FirebaseDatabase.instance.reference().child(users);

      ref
          .child(userCredential.user!.uid)
          .set(MyUser(
                  email: emailController.value.text,
                  name: nameController.value.text,
                  bloodType: bloodController.value.text,
                  phone: phoneController.value.text,
                  insuranceId: insuranceController.value.text,
                  address: addressController.value.text,
                  birthDate: dateController.value.text,
                  sex: selectedSex ?? 'Male')
              .toMap())
          .then((value) {
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

  showPickDate() {
    showDatePicker(
            context: context,
            lastDate: DateTime.now(),
            firstDate: DateTime(1800),
            initialDate: DateTime.now())
        .then((value) {
      if (value != null) {
        dateController.text = '${value.year} -${value.month} -${value.day}';
        setState(() {});
      }
    });
  }
}
