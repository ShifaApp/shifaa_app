import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/const/route_constants.dart';
import 'package:shifa_app_flutter/design/color.dart';
import 'package:shifa_app_flutter/screen/widget/app_bar_design.dart';
import 'package:shifa_app_flutter/screen/widget/buttons_class.dart';

import '../../../const/const.dart';
import '../../../dialogs/snack_message.dart';
import '../../../helpers/route_helper.dart';
import '../../../models/Appointemnts.dart';

class AddAppointment extends StatefulWidget {
  const AddAppointment({Key? key}) : super(key: key);

  @override
  State<AddAppointment> createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBarWithBck('Add Appointment'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () => _selectDate(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: CustomColors.lightBlueColor,
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Pick Date and time you will be free at them ',
                          style: TextStyle(
                              fontSize: 20,
                              color: CustomColors.primaryBlackColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              lightBlueBtn('select date', const EdgeInsets.all(20),
                  () => _selectDate(context)),
              if (selectedDate != null && selectedTime != null)
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: CustomColors.lightBlueColor, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.date_range, color: Colors.green),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${selectedDate!.day} - ${selectedDate!.month} - ${selectedDate!.year}  ${selectedTime!.hour}: ${selectedTime!.minute}  ${selectedTime!.period.name}",
                              maxLines: 2,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    lightBlueBtn(
                        'Confirm Appointment', const EdgeInsets.all(20), () {
                      DatabaseReference ref = FirebaseDatabase.instance
                          .reference()
                          .child(hospitals)
                       //   .child()
                          .child(doctors)
                          .child(FirebaseAuth.instance.currentUser!.uid);
                      ref
                          .push()
                          .update(Appointments(
                                  date:
                                      "${selectedDate!.day} - ${selectedDate!.month} - ${selectedDate!.year}  ${selectedTime!.hour}: ${selectedTime!.minute}  ${selectedTime!.period.name}",
                                  doctorId:
                                      FirebaseAuth.instance.currentUser!.uid,
                            //      hospitalName: widget.doctor.specialist!,
                              //    doctorName: ,
                                  completed: false)
                              .toMap())
                          .then((value) {
                        showSuccessMessage(
                            context, 'Your Appointment added  successfully');
                        moveToNewStack(context, doctorDashBoardRoute);
                      });
                    })
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 4));
    if (picked != null && picked != selectedDate) {
      _selectTime(context, picked);
      // setState(() {
      //   selectedDate = picked;
      // });
    }
  }

  Future<Null> _selectTime(BuildContext context, pickedDate) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 00, minute: 00),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        selectedDate = pickedDate;
        // _timeController.text = formatDate(
        //     DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
        //     [hh, ':', nn, " ", am]).toString();
      });
    }
  }
}
