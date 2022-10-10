import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/models/Hospitals.dart';
import 'package:shifa_app_flutter/screen/screens/doctor_details.dart';
import 'package:shifa_app_flutter/screen/widget/app_bar_design.dart';

import '../../design/color.dart';
import '../../helpers/contact_helper.dart';

class HospitalDetails extends StatefulWidget {
  final Hospitals hospital;
  const HospitalDetails({Key? key, required this.hospital}) : super(key: key);

  @override
  State<HospitalDetails> createState() => _HospitalDetailsState();
}

class _HospitalDetailsState extends State<HospitalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBarWithBck(widget.hospital.name!),
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
                child: widget.hospital.image != null
                    ? Image.network(
                        widget.hospital.image!,
                        fit: BoxFit.fill,
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
                    border: Border.all(
                        color: CustomColors.lightBlueColor, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.location_on_outlined,
                            color: Colors.green),
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
              ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if(widget.hospital.doctors![index] !=null ) {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DoctorDetails(
                          doctor: widget.hospital.doctors![index],
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
                                child: widget.hospital.doctors![index].image !=
                                        null
                                    ? Image.network(
                                        widget.hospital.doctors![index].image!,
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
                              widget.hospital.doctors![index].name != null
                                  ? widget.hospital.doctors![index].name!
                                  : '',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.hospital.doctors![index].specialist != null
                                  ? widget.hospital.doctors![index].specialist!
                                  : "",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: widget.hospital.doctors!.length,
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
