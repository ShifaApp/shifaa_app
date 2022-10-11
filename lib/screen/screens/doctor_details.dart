import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/const/route_constants.dart';
import 'package:shifa_app_flutter/dialogs/snack_message.dart';
import 'package:shifa_app_flutter/helpers/route_helper.dart';
import 'package:shifa_app_flutter/models/user.dart';
import 'package:shifa_app_flutter/screen/widget/buttons_class.dart';

import '../../const/const.dart';
import '../../design/color.dart';
import '../../helpers/contact_helper.dart';
import '../../models/Doctors.dart';
import '../../models/Appointemnts.dart';
import '../widget/app_bar_design.dart';

class DoctorDetails extends StatefulWidget {
  final Doctors doctor;
  const DoctorDetails({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBarWithBck(widget.doctor.name!),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height / 5,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: CustomColors.lightBlueColor, width: 3),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: widget.doctor.image != null
                    ? Image.network(
                        widget.doctor.image!,
                        fit: BoxFit.fill,
                      )
                    : Image.asset('assests/shifa.png'),
              ),
              Divider(
                color: CustomColors.lightGrayColor,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: CustomColors.lightBlueColor, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.attach_money_outlined,
                          color: Colors.green),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${widget.doctor.fees!} SR',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  directToPhoneCall(widget.doctor.phone.toString());
                },
                child: Container(
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
                        child: Icon(Icons.phone, color: Colors.green),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.doctor.phone!.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: CustomColors.lightBlueColor, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.document_scanner, color: Colors.green),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.doctor.specialist!,
                        maxLines: 2,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: CustomColors.lightGrayColor,
              ),

              // lightBlueBtn('Reserve an Appointment date', const EdgeInsets.all(20), () => _selectDate(context)),

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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Click to Reserve an Appointment date',
                          maxLines: 2,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                        'Confirm appointment', const EdgeInsets.all(20), () {
                      DatabaseReference ref = FirebaseDatabase.instance
                          .reference()
                          .child(users)
                          .child(FirebaseAuth.instance.currentUser!.uid)
                          .child(appointments);

                      ref
                          .push()
                          .update(Appointments(
                                  date:
                                      " ${selectedDate!.day} - ${selectedDate!.month} - ${selectedDate!.year}  ${selectedTime!.hour}: ${selectedTime!.minute}  ${selectedTime!.period.name}",
                                  doctorName: widget.doctor.name!,
                                  hospitalName: widget.doctor.specialist!,
                                  completed: false)
                              .toMap())
                          .then((value) {
                        showSuccessMessage(
                            context, 'Your reservation done successfully');
                        moveToNewStack(context, dashBoardRoute);
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
