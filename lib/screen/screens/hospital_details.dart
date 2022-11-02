import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/models/Doctors.dart';
import 'package:shifa_app_flutter/models/Hospitals.dart';
import 'package:shifa_app_flutter/screen/screens/doctor_details.dart';
import 'package:shifa_app_flutter/screen/widget/app_bar_design.dart';

import '../../const/const.dart';
import '../../design/color.dart';
import '../../helpers/contact_helper.dart';
import '../../models/user.dart';

class HospitalDetails extends StatefulWidget {
  final Hospitals hospital;

  const HospitalDetails({Key? key, required this.hospital}) : super(key: key);

  @override
  State<HospitalDetails> createState() => _HospitalDetailsState();
}

class _HospitalDetailsState extends State<HospitalDetails> {
  List<Doctors>? doctor;
  @override
  void initState() {
    super.initState();

    DatabaseReference ref = FirebaseDatabase.instance
        .reference()

        .child(doctors);


    ref.once().then((value) {
      if (value.snapshot.exists) {
        var values = value.snapshot.children;
        for(var one in values){
          Doctors doctors = Doctors.fromJson(one.value);

          if(doctors.hospitalId == widget.hospital.hospitalId!) {

            if(doctor == null) doctor = [];
            doctor!.add(doctors);
              setState(() {});
          }
        }


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(doctor.toString());

    return Scaffold(
      appBar: basicAppBarWithBck(widget.hospital.name!),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: CustomColors.lightBlueColor, width: 3),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: widget.hospital.image != null
                    ? Image.network(
                        widget.hospital.image!,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                      )
                    : Image.asset('assests/shifa.png'),
              ),
              Divider(
                color: CustomColors.lightGrayColor,
              ),
              InkWell(
                onTap: () {
                  directToPhoneCall(widget.hospital.phone.toString());
                },
                child: Container(
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
                        child: Icon(Icons.phone, color: Colors.green),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.hospital.phone!.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  //  openMap(widget.hospital.);
                },
                child: Container(
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
                        child:
                            Icon(Icons.location_on_outlined, color: Colors.green),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.hospital.address!,
                          maxLines: 2,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: CustomColors.lightGrayColor,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Doctors',
                      style: TextStyle(
                          color: CustomColors.lightBlueColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),

              // FirebaseAnimatedList(
              //   query: FirebaseDatabase.instance.reference().child(hospitals).child(widget.hospital.hospitalId!).child(doctors),
              //   itemBuilder: (BuildContext context, DataSnapshot snapshot,
              //       Animation<double> animation, int index) {
              //     if (snapshot.exists && snapshot.value != null) {
              //       print(snapshot.value);
              //       Doctors doctor = Doctors.fromJson(snapshot.value);
              //
              //       //list item design
              //       return InkWell(
              //         onTap: () {
              //           if(doctor !=null ) {
              //             Navigator.push(context,
              //                 MaterialPageRoute(builder: (context) {
              //                   return DoctorDetails(
              //                   //  myUser: widget.myUser,
              //                     doctor: doctor,
              //                   );
              //                 }));
              //           }
              //         },
              //         child: Container(
              //           //    height: MediaQuery.of(context).size.height/3,
              //           margin: const EdgeInsets.all(10),
              //           //    height: MediaQuery.of(context).size.height/7,
              //           decoration: BoxDecoration(
              //             color: CustomColors.primaryWhiteColor,
              //             borderRadius: BorderRadius.circular(10),
              //             border: Border.all(
              //                 color: CustomColors.lightBlueColor, width: 3),
              //           ),
              //           child: Column(
              //             children: [
              //               Container(
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(10),
              //                 ),
              //                 child: Padding(
              //                   padding: const EdgeInsets.only(top: 8.0),
              //                   child: SizedBox(
              //                     height: MediaQuery.of(context).size.height / 8,
              //                     child: doctor.image !=
              //                         null
              //                         ? Image.network(
              //                       doctor.image!,
              //                       fit: BoxFit.fill,
              //                     )
              //                         : Image.asset('assests/shifa.png'),
              //                   ),
              //                 ),
              //               ),
              //               Divider(
              //                 color: CustomColors.lightBlueColor,
              //                 height: 3,
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Text(
              //                   doctor.name != null
              //                       ? doctor.name!
              //                       : '',
              //                   style: const TextStyle(
              //                       fontSize: 18, fontWeight: FontWeight.w800),
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Text(
              //                   doctor.specialist != null
              //                       ? doctor.specialist!
              //                       : "",
              //                   style: const TextStyle(
              //                       fontSize: 16, fontWeight: FontWeight.w500),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     } else {
              //       return const Text('no data ');
              //     }
              //   },
              // ),
              if (doctor!=null )
                GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:2,
                    ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (doctor![index] != null) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DoctorDetails(
                              doctor: doctor![index],
                            );
                          }));
                        }
                      },
                      child: Container(
                        //    height: MediaQuery.of(context).size.height/3,
                        margin: const EdgeInsets.all(10),
                        //    height: MediaQuery.of(context).size.height/7,
                        decoration: BoxDecoration(
                          color: CustomColors.primaryWhiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: CustomColors.lightBlueColor, width: 3),
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
                                  child: doctor![index].image != null
                                      ? Image.network(
                                          doctor![index].image!,
                                      //    fit: BoxFit.fill,  width: MediaQuery.of(context).size.width
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
                                doctor![index].name ?? '',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(

                                    doctor![index].specialist  ??
                                    "",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: doctor!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
