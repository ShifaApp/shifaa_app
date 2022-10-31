import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/const/const.dart';

import '../../design/color.dart';
import '../../models/Appointemnts.dart';
import '../widget/app_bar_design.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('Appointments'),
      body: FirebaseAnimatedList(
        query: FirebaseDatabase.instance
            .reference()
            .child(users)
            .child(Const.currentUserId)
            .child(appointments),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          if (snapshot.exists && snapshot.value != null) {
            Appointments appointments = Appointments.fromJson(snapshot.value);

            //list item design
            return Container(
              margin: const EdgeInsets.all(10),
              //    height: MediaQuery.of(context).size.height/7,
              decoration: BoxDecoration(
                color: appointments.completed!
                    ? Colors.green.withOpacity(0.3)
                    : CustomColors.primaryWhiteColor,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: CustomColors.lightBlueColor, width: 1),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Text(
                          'Appointment date:',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: CustomColors.primaryBlackColor),
                        ),
                        Text(
                          appointments.date!,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: CustomColors.lightBlueColor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Text(
                          'Doctor Name: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: CustomColors.primaryBlackColor),
                        ),
                        Text(
                          appointments.doctorName!,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: CustomColors.lightBlueColor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Text(
                          'Appointment Type: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: CustomColors.primaryBlackColor),
                        ),
                        Text(
                          appointments.appointmentType ?? ' ',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: CustomColors.lightBlueColor),
                        ),
                      ],
                    ),
                  ),
                ],
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
