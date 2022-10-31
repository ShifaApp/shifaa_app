import 'package:flutter/material.dart';

import '../../../design/color.dart';
import '../../../helpers/contact_helper.dart';
import '../../../models/Doctors.dart';
import '../../widget/app_bar_design.dart';

class HospitalDoctorDetails extends StatefulWidget {
  final Doctors doctor;
  const HospitalDoctorDetails({Key? key,required this.doctor}) : super(key: key);

  @override
  State<HospitalDoctorDetails> createState() => _HospitalDoctorDetailsState();
}

class _HospitalDoctorDetailsState extends State<HospitalDoctorDetails> {
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


            ],
          ),
        ),
      ),
    );
  }
}
