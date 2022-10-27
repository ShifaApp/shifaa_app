import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/dialogs/snack_message.dart';
import 'package:shifa_app_flutter/models/Doctors.dart';
import 'package:shifa_app_flutter/models/Recipe.dart';
import 'package:shifa_app_flutter/screen/widget/buttons_class.dart';
import 'package:shifa_app_flutter/screen/widget/text_field_class.dart';

import '../../../const/const.dart';
import '../../../const/route_constants.dart';
import '../../../design/color.dart';
import '../../../helpers/route_helper.dart';
import '../../../models/Appointemnts.dart';
import '../../widget/app_bar_design.dart';
import 'doctor_dashboard.dart';

class AddRecipe extends StatefulWidget {
  final Appointments appointments;

  const AddRecipe({Key? key, required this.appointments}) : super(key: key);

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final TextEditingController diagnosisController = TextEditingController();
  final TextEditingController recipeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBarWithBck('Add Recipe'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Appointment date',
                      style: TextStyle(
                          fontSize: 18, color: CustomColors.primaryBlackColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.appointments.date ?? '',
                      style: TextStyle(
                          fontSize: 18, color: CustomColors.lightBlueColor),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Appointment Type',
                      style: TextStyle(
                          fontSize: 18, color: CustomColors.primaryBlackColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.appointments.appointmentType ?? '',
                      style: TextStyle(
                          fontSize: 18, color: CustomColors.lightBlueColor),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Patient Name',
                      style: TextStyle(
                          fontSize: 18, color: CustomColors.primaryBlackColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.appointments.patientName ?? '',
                      style: TextStyle(
                          fontSize: 18, color: CustomColors.lightBlueColor),
                    ),
                  ),
                ],
              ),
              const Divider(),
              largeTextFieldStyle(
                  context: context,
                  edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                  lbTxt: 'Diagnosis',
                  controller: diagnosisController,
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.next),
              largeTextFieldStyle(
                  context: context,
                  edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
                  lbTxt: 'Recipe',
                  controller: recipeController,
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.go),
              lightBlueBtn('Confirm', const EdgeInsets.all(20), () {
                if (widget.appointments.patientId != null &&
                    widget.appointments.patientId != '') {
                  DatabaseReference ref = FirebaseDatabase.instance
                      .reference()
                      .child(users)
                      .child(widget.appointments.patientId!)
                      .child(recipes);
                  ref
                      .push()
                      .update(Recipe(
                              appointmentDate: widget.appointments.date ?? '',
                              appointmentType:
                                  widget.appointments.appointmentType ?? '',
                              doctorName: widget.appointments.doctorName!,
                              patientName:
                                  widget.appointments.patientName ?? '',
                              patientId: widget.appointments.patientId!,
                              diagnosis: diagnosisController.value.text,
                              recipe: recipeController.value.text)
                          .toMap())
                      .then((value) {
                    showSuccessMessage(context, 'Recipe added successfully');
                    moveToNewStackWithArgs(context, MaterialPageRoute(builder: (context) {
                      return DoctorDashboard();
                    }));
                  });
                } else {
                  showSuccessMessage(context, 'Something Error happend');
                }
              })
            ],
          ),
        ),
      ),
    );
    ;
  }
}
