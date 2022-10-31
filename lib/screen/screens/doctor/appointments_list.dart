import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/models/Appointemnts.dart';
import 'package:shifa_app_flutter/models/Doctors.dart';

import '../../../const/const.dart';
import '../../../design/color.dart';
import '../../widget/app_bar_design.dart';

class AppointmentsList extends StatefulWidget {
  final Doctors doctors;
 final bool selected;

  const AppointmentsList({Key? key,required this.doctors,this.selected= false}) : super(key: key);

  @override
  State<AppointmentsList> createState() => _AppointmentsListState();
}

class _AppointmentsListState extends State<AppointmentsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('Appointments List'),
      body: FirebaseAnimatedList(
        query: FirebaseDatabase.instance.reference().child(hospitals).child(widget.doctors.hospitalId!).child(widget.doctors.doctorId!).child(appointments),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          if (snapshot.exists && snapshot.value != null) {
            print(snapshot.value);
            Appointments appointments = Appointments.fromJson(snapshot.value);

            //list item design
            return InkWell(
              onTap: () {

                Navigator.pop(context , appointments);
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                //    height: MediaQuery.of(context).size.height/7,
                decoration: BoxDecoration(
                  color: CustomColors.primaryWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border:
                  Border.all(color: CustomColors.lightBlueColor, width: 3),
                ),
                child: ListTile(
                  leading: Icon(Icons.check_circle_outline_outlined,color: widget.selected ? CustomColors.lightBlueColor: CustomColors.darkGrayColor, ),
                  title:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      appointments.date!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ),
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
