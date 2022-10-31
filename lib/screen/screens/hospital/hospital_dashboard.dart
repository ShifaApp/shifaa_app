import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/models/Doctors.dart';
import 'package:shifa_app_flutter/models/Hospitals.dart';
import 'package:shifa_app_flutter/screen/screens/doctor/login_doctor.dart';
import 'package:shifa_app_flutter/screen/screens/doctor_details.dart';
import 'package:shifa_app_flutter/screen/screens/hospital/edit_hospital_info.dart';
import 'package:shifa_app_flutter/screen/screens/hospital/register_doctor.dart';

import '../../../const/const.dart';
import '../../../const/route_constants.dart';
import '../../../design/color.dart';
import '../../../helpers/route_helper.dart';
import '../../widget/app_bar_design.dart';
import 'hospital_doctor_details.dart';

class HospitalDashboard extends StatefulWidget {
  const HospitalDashboard({Key? key}) : super(key: key);

  @override
  State<HospitalDashboard> createState() => _HospitalDashboardState();
}

class _HospitalDashboardState extends State<HospitalDashboard> {
  late Hospitals? hospital;
  String hospitalId = '';
  @override
  void initState() {
    super.initState();

    DatabaseReference ref =
        FirebaseDatabase.instance.reference().child(hospitals);

    ref.child(Const.currentUserId).get().then((h) {
      if (h.exists) {
        hospital = Hospitals.fromJson(h.value);
        setState(() {
          hospitalId = hospital!.hospitalId!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBarWithMenu('Hospital', (context) {
        return [
          const PopupMenuItem<int>(
            value: 0,
            child: Text("Account"),
          ),
          const PopupMenuItem<int>(
            value: 1,
            child: Text("Add Doctor"),
          ),
          const PopupMenuItem<int>(
            value: 2,
            child: Text("Login Doctor"),
          ),
          const PopupMenuItem<int>(
            value: 3,
            child: Text("Logout"),
          ),
        ];
      }, (value) {
        if (value == 0) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HospitalInfo()));
        } else if (value == 1) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegisterDoctor()));
        } else if (value == 2) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginDoctor()));
        } else if (value == 3) {
          FirebaseAuth.instance.signOut().then((value) {
            moveToNewStack(context, loginRoute);
          });
        }
      }),
      body: FirebaseAnimatedList(
        query: FirebaseDatabase.instance
            .reference()
            .child(hospitals)
            .child(Const.currentUserId)
            .child(doctors),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          if (snapshot.exists && snapshot.value != null) {
            Map<dynamic, dynamic> map = snapshot.value as Map<dynamic, dynamic>  ;
            Doctors doctor = Doctors.fromJson(map);

            //list item design
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HospitalDoctorDetails(
                    doctor: doctor,
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
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 8,
                          child: doctor.image != null
                              ? Image.network(
                                  doctor.image!,
                                  fit: BoxFit.fill,
                                )
                              : Image.asset('assests/shifa.png'),
                        ),
                      ),
                    ),
                    Divider(
                      color: CustomColors.lightBlueColor,
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        doctor.name != null ? doctor.name! : '',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        doctor.specialist != null ? doctor.specialist! : "",
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
