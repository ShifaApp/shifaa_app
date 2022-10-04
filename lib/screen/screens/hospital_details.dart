import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/models/Hospitals.dart';
import 'package:shifa_app_flutter/screen/widget/app_bar_design.dart';

import '../../design/color.dart';

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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top:10),

              height: MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                border:
                    Border.all(color: CustomColors.lightBlueColor, width: 3),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Image.network(
                widget.hospital.image!,
                fit: BoxFit.fill,
              ),
            ),
            Divider(
              color:  CustomColors.lightGrayColor,
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
                    child: Icon(Icons.phone , color: Colors.green),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.hospital.phone!.toString(),style: const TextStyle(fontSize: 16 ), ),
                  ),
                ],
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
                    child: Icon(Icons.location_on_outlined , color: Colors.green),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.hospital.address!,maxLines: 2,style: const TextStyle(fontSize: 16 ), ),
                  ),

                ],
              ),
            ),



            Divider(
              color:  CustomColors.lightGrayColor,
            )
          ],
        ),
      ),
    );
  }
}
