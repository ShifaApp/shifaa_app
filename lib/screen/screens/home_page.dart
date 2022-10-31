import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/design/color.dart';
import 'package:shifa_app_flutter/models/Hospitals.dart';
import 'package:shifa_app_flutter/screen/screens/hospital_details.dart';

import '../../const/const.dart';
import '../../models/user.dart';
import '../widget/app_bar_design.dart';

class HomePage extends StatefulWidget {


  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('Home'),
      body: FirebaseAnimatedList(
        query: FirebaseDatabase.instance.reference().child(hospitals),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          if (snapshot.exists && snapshot.value != null) {
            print(snapshot.value);
            Hospitals hospital = Hospitals.fromJson(snapshot.value);

            //list item design
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HospitalDetails(
                    hospital: hospital
                  );
                }));
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
                child: Column(
                  children: [
                    Container(height: MediaQuery.of(context).size.height/5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Image.network(width:  MediaQuery.of(context).size.width,
                          hospital.image!,        fit: BoxFit.fill,
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
                        hospital.name!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        hospital.address!,
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
