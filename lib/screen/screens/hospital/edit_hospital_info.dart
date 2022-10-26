import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shifa_app_flutter/models/Hospitals.dart';
import 'package:shifa_app_flutter/screen/widget/app_bar_design.dart';

import '../../../const/const.dart';
import '../../../const/route_constants.dart';
import '../../../design/color.dart';
import '../../../dialogs/snack_message.dart';
import '../../../helpers/route_helper.dart';
import '../../widget/buttons_class.dart';
import '../../widget/text_field_class.dart';

class HospitalInfo extends StatefulWidget {
  final Hospitals hospitals;
  const HospitalInfo({Key? key,required this.hospitals}) : super(key: key);

  @override
  State<HospitalInfo> createState() => _HospitalInfoState();
}

class _HospitalInfoState extends State<HospitalInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isBtnEnabled = true;
  XFile? pickedImage;

  String imageUrl ='';
  @override
  void initState() {
    super.initState();


        nameController.text = widget.hospitals.name ?? ' ';
        addressController.text =  widget.hospitals.address ?? ' ';
        emailController.text =  widget.hospitals.email ?? ' ';
        phoneController.text =  widget.hospitals.phone ?? ' ';
        imageUrl =  widget.hospitals.email ?? ' ';

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBarWithBck('Account'),
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
                            : Image.network(imageUrl)),
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
                    textInputAction: TextInputAction.done),

                lightBlueBtn(
                    'Continue', const EdgeInsets.only(bottom: 10, top: 10),
                        () {
                      continueSignUp();

                      //
                    }),
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

  void continueSignUp() {

    if(pickedImage != null){
      var storageRef = FirebaseStorage.instance.ref().child("images");
      storageRef.putFile(File(pickedImage!.path)).whenComplete(() async {
        var url = await storageRef.getDownloadURL();
        imageUrl = url.toString();
      }).catchError((onError) {
        print(onError);
      });
    }
    DatabaseReference ref =
    FirebaseDatabase.instance.reference().child(hospitals);

    ref
        .child(FirebaseAuth.instance.currentUser!.uid)
        .update(Hospitals(
        email: emailController.value.text,
        name: nameController.value.text,
        phone: phoneController.value.text,image: imageUrl,
        address: addressController.value.text)
        .toMap())
        .then((value) {
      showSuccessMessage(context, 'Your info updated successfully');
      moveToNewStack(context, hospitalDashBoardRoute);
    });
  }


}
