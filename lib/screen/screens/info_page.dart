import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/design/color.dart';
import 'package:shifa_app_flutter/dialogs/progress_dialog.dart';

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
  bool isBtnEnabled = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference ref =
    FirebaseDatabase.instance.reference().child(users);

    ref
        .child(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((user) {
          if(user.exists){
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
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.primaryWhiteColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      color: CustomColors.purpleColor,
                      iconSize: 30,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              ////////////////////////////

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
                  lbTxt: 'blood group',
                  controller: bloodController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done),
              lightBlueBtn('update', const EdgeInsets.only(bottom: 10, top: 10),
                  () {
                DatabaseReference ref =
                    FirebaseDatabase.instance.reference().child(users);

                ref
                    .child(FirebaseAuth.instance.currentUser!.uid)
                    .update(MyUser(
                            email: emailController.value.text,
                            name: nameController.value.text,
                            bloodType: bloodController.value.text)
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

}
