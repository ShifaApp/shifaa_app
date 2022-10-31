import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/models/Appointemnts.dart';
import 'package:shifa_app_flutter/models/Doctors.dart';
import 'package:shifa_app_flutter/screen/screens/doctor/appointment_details.dart';
import 'package:shifa_app_flutter/screen/screens/doctor/doctor_info.dart';

import '../../../const/const.dart';
import '../../../const/route_constants.dart';
import '../../../design/color.dart';
import '../../../helpers/route_helper.dart';
import '../../widget/app_bar_design.dart';
import 'add_appointement.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({Key? key}) : super(key: key);

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  // late Doctors doctor;
  // @override
  // void initState() {
  //   super.initState();
  //
  //   DatabaseReference ref =
  //   FirebaseDatabase.instance.reference().child(hospitals).child(Const.currentUserId).child(doctors);
  //
  //   ref.child(Const.doctorId).get().then((h) {
  //     if (h.exists) {
  //
  //       doctor = Doctors.fromJson(h.value);
  //       setState(() {
  //      //   hospitalId = hospital!.hospitalId!;
  //       });
  //     }
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBarWithMenu('Doctor', (context) {
        return [
          const PopupMenuItem<int>(
            value: 0,
            child: Text("Account"),
          ),
          const PopupMenuItem<int>(
            value: 1,
            child: Text("Add Appointment"),
          ),
          const PopupMenuItem<int>(
            value: 2,
            child: Text("Logout"),
          ),
        ];
      }, (value) {
        if (value == 0) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DoctorInfo()));
        } else if (value == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  AddAppointment(
                      // doctors:doctor,
                      )));
        } else if (value == 2) {
          FirebaseAuth.instance.signOut().then((value) {
            moveToNewStack(context, loginRoute);
          });
        }
      }),
      body: FirebaseAnimatedList(
        query: FirebaseDatabase.instance
            .reference()
          //  .child(hospitals)

            .child(doctors)
            .child(Const.currentUserId)
            .child(appointments),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          if (snapshot.exists && snapshot.value != null) {
            Appointments appointments = Appointments.fromJson(snapshot.value);

            //list item design
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AppointmentDetails(
                    appointments: appointments
                  );
                }));
              },
              child: Container(
                //    height: MediaQuery.of(context).size.height/3,
                margin: const EdgeInsets.all(10),
                //    height: MediaQuery.of(context).size.height/7,
                decoration: BoxDecoration(
                  color: CustomColors.primaryWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: CustomColors.lightBlueColor, width: 3),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        appointments.date ?? '',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        appointments.patientName ?? "No Patient yet",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Text('no data ');
          }
        },
      ),
    );
  }
}
