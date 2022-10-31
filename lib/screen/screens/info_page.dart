import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/design/color.dart';
import 'package:shifa_app_flutter/dialogs/progress_dialog.dart';
import 'package:shifa_app_flutter/screen/widget/app_bar_design.dart';

import '../../const/const.dart';
import '../../const/route_constants.dart';
import '../../dialogs/snack_message.dart';
import '../../helpers/route_helper.dart';
import '../../models/user.dart';
import '../widget/buttons_class.dart';
import '../widget/text_field_class.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({Key? key}) : super(key: key);

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bloodController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController insuranceController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  bool isBtnEnabled = true;
  List<String> sexList = ['Select Your Sex ', 'Male', 'Female'];
  String? selectedSex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.reference().child(users);

    ref.child(FirebaseAuth.instance.currentUser!.uid).get().then((user) {
      if (user.exists) {
        MyUser myUser = MyUser.fromJson(user.value);
        nameController.text = myUser.name ?? ' ';
        bloodController.text = myUser.bloodType ?? ' ';
        emailController.text = myUser.email ?? ' ';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBarWithBck('My Information'),
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.primaryWhiteColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              ////////////////////////////

              const SizedBox(
                height: 20,
              ),
              textFieldStyle(
                  context: context,
                  edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                  lbTxt: 'your Name',
                  textInputType: TextInputType.name,
                  controller: nameController,
                  textInputAction: TextInputAction.next),
              textFieldStyle(
                  context: context,
                  edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                  lbTxt: 'Your Email',
                  controller: emailController,
                  enabled: false,
                  textInputType: TextInputType.emailAddress,
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
                    decoration: const InputDecoration.collapsed(hintText: ''),
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
                    items:
                        sexList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              lightBlueBtn('update', const EdgeInsets.only(bottom: 10, top: 10),
                  () {
                DatabaseReference ref =
                    FirebaseDatabase.instance.reference().child(users);

                ref
                    .child(FirebaseAuth.instance.currentUser!.uid)
                    .update(MyUser(
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
                  showSuccessMessage(context, 'Your info updated successfully');
                  moveToNewStack(context, dashBoardRoute);
                });
              }),
            ],
          ),
        ),
      ),
    );
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
