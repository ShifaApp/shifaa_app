import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/const/route_constants.dart';
import 'package:shifa_app_flutter/dialogs/snack_message.dart';
import 'package:shifa_app_flutter/helpers/route_helper.dart';
import 'package:shifa_app_flutter/models/user.dart';
import 'package:shifa_app_flutter/screen/screens/payment_page.dart';
import 'package:shifa_app_flutter/screen/widget/buttons_class.dart';

import '../../const/const.dart';
import '../../design/color.dart';
import '../../helpers/contact_helper.dart';
import '../../models/Doctors.dart';
import '../../models/Appointemnts.dart';
import '../widget/app_bar_design.dart';

class DoctorDetails extends StatefulWidget {
  final Doctors doctor;
  //final MyUser? myUser;

  const DoctorDetails({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  List<Appointments> appointmentsList = [];

  bool selectedAppointments = false;
  Appointments first = Appointments(date: 'Select Appointment');
  Appointments indexAppointment = Appointments();
  @override
  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance
        .reference()
        .child(doctors)
        .child(widget.doctor.doctorId!);

    ref.child(appointments).once().then((value) {
      if (value.snapshot.exists) {
        var values = value.snapshot.children;
        for (var one in values) {
          Appointments appointments = Appointments.fromJson(one.value);
          appointmentsList.add(appointments);
          setState(() {});
        }

        appointmentsList.insert(0, first);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBarWithBck(widget.doctor.name!),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        width: MediaQuery.of(context).size.width,
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
              if (appointmentsList.isNotEmpty)
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: CustomColors.lightBlueColor, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField<Appointments>(
                          value: first,
                          decoration:
                              const InputDecoration.collapsed(hintText: ''),
                          // icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: TextStyle(
                            color: CustomColors.darkGrayColor,
                          ),
                          onChanged: (Appointments? newValue) {
                            if (newValue != first) {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                indexAppointment = newValue!;
                              });
                            } else {
                              indexAppointment = Appointments();
                            }
                          },
                          items: appointmentsList
                              .map<DropdownMenuItem<Appointments>>(
                                  (Appointments value) {
                            return DropdownMenuItem<Appointments>(
                              value: value,
                              child: Text(
                                '${value.date ?? ''}: ${value.appointmentType ?? ''}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w800),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              if (indexAppointment.date != null)
                Column(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            ' Selected Appointment is: ',
                            maxLines: 2,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${indexAppointment.date ?? ''} \n ${indexAppointment.appointmentType ?? ''}',
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 16,
                                color: CustomColors.lightBlueColor,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                    lightBlueBtn('Continue Payment', const EdgeInsets.all(20),
                        () {
                      if (Const.isUserGuest == false) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PaymentPage(
                            //  myUser: widget.myUser!,
                            date: indexAppointment,
                          );
                        }));
                      } else {
                        showSuccessMessage(
                            context, 'You Have to Log In first ');
                      }
                    })
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
