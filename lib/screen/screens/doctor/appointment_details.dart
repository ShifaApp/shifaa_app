import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/const/const.dart';
import 'package:shifa_app_flutter/design/color.dart';
import 'package:shifa_app_flutter/models/Appointemnts.dart';
import 'package:shifa_app_flutter/screen/screens/doctor/add_recipe.dart';
import 'package:shifa_app_flutter/screen/widget/app_bar_design.dart';
import 'package:shifa_app_flutter/screen/widget/buttons_class.dart';

import '../../../models/Doctors.dart';

class AppointmentDetails extends StatefulWidget {
  final Appointments appointments;
  const AppointmentDetails({Key? key, required this.appointments})
      : super(key: key);

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  bool closeAppointment = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBarWithBck('Appointment'),
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
                          fontSize: 18, color: CustomColors.primaryBlackColor),
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
                          fontSize: 18, color: CustomColors.primaryBlackColor),
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
                          fontSize: 18, color: CustomColors.primaryBlackColor),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Payment Type',
                      style: TextStyle(
                          fontSize: 18, color: CustomColors.primaryBlackColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.appointments.paymentType ?? '',
                      style: TextStyle(
                          fontSize: 18, color: CustomColors.primaryBlackColor),
                    ),
                  ),
                ],
              ),
              if (!closeAppointment)
                lightBlueBtn('Close appointment ', const EdgeInsets.all(20),
                    () {
                  setState(() {
                    closeAppointment = true;
                  });
                }),
              if (closeAppointment)
                lightBlueBtn('Add Recipe ', const EdgeInsets.all(20), () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return  AddRecipe(appointments: widget.appointments);
                  }));
                }),
            ],
          ),
        ),
      ),
    );
  }
}
