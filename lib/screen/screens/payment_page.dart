import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/screen/widget/app_bar_design.dart';

import '../../const/const.dart';
import '../../const/route_constants.dart';
import '../../design/color.dart';
import '../../dialogs/snack_message.dart';
import '../../helpers/route_helper.dart';
import '../../models/Appointemnts.dart';
import '../../models/Doctors.dart';
import '../widget/buttons_class.dart';
import '../widget/text_field_class.dart';

class PaymentPage extends StatefulWidget {
  final Doctors doctor;
  final String date;
  const PaymentPage({Key? key, required this.doctor, required this.date})
      : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isCashSelected = true;
  bool isInsuranceSelected = false;
  String paymentType = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: basicAppBarWithBck('Payment'),
      body: SafeArea(
        child: Center(
          child: Column(
            //
            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Select your payment type: ',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: CustomColors.lightBlueColor),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        isCashSelected = true;
                        isInsuranceSelected = false;
                        paymentType = 'Cash';
                        setState(() {});
                      },
                      child: Container(
                        // width: MediaQuery.of(context).size.width * 0.27,
                        //height: MediaQuery.of(context).size.height * 0.094,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: !isCashSelected
                                    ? CustomColors.darkGrayColor
                                    : CustomColors.lightBlueColor)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.attach_money_outlined,
                              color: !isCashSelected
                                  ? CustomColors.darkGrayColor
                                  : CustomColors.lightBlueColor,
                              size: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Cash',
                                style: TextStyle(
                                    color: !isCashSelected
                                        ? CustomColors.darkGrayColor
                                        : CustomColors.lightBlueColor,
                                    fontSize: 13),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        isCashSelected = false;

                        isInsuranceSelected = true;
                        paymentType = 'Insurance';
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),

                        // width: MediaQuery.of(context).size.width * 0.27,
                        //height: MediaQuery.of(context).size.height * 0.094,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: !isInsuranceSelected
                                    ? CustomColors.darkGrayColor
                                    : CustomColors.lightBlueColor)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.credit_card,
                              color: !isInsuranceSelected
                                  ? CustomColors.darkGrayColor
                                  : CustomColors.lightBlueColor,
                              size: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Insurance',
                                style: TextStyle(
                                    color: !isInsuranceSelected
                                        ? CustomColors.darkGrayColor
                                        : CustomColors.lightBlueColor,
                                    fontSize: 13),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (isCashSelected) cashInfo(),
              if (isInsuranceSelected) insuranceInfo(),
            ],
          ),
        ),
      ),
    );
  }

  cashInfo() {
    return Column(
      children: [
        textFieldStyle(
            context: context,
            edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
            lbTxt: 'Your Credit Number',
            //controller: emailController,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next),
        textFieldStyle(
            context: context,
            edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
            lbTxt: 'Your Credit Name',
            //  controller: emailController,
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.next),
        textFieldStyle(
            context: context,
            edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
            lbTxt: 'Expire Date',
            // controller: emailController,
            textInputType: TextInputType.datetime,
            textInputAction: TextInputAction.next),
        textFieldStyle(
            context: context,
            edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
            lbTxt: 'CCV',
            // controller: emailController,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.go),
        lightBlueBtn('Confirm appointment', const EdgeInsets.all(20), () {
          confirmAppointment();
        }),
      ],
    );
  }

  void confirmAppointment() {
    DatabaseReference ref = FirebaseDatabase.instance
        .reference()
        .child(users)
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(appointments);

    ref
        .push()
        .update(Appointments(
                date: widget.date,
                paymentType: paymentType,
                doctorName: widget.doctor.name!,
                hospitalName: widget.doctor.specialist!,
                completed: false)
            .toMap())
        .then((value) {
      showSuccessMessage(context, 'Your reservation done successfully');
      moveToNewStack(context, dashBoardRoute);
    });
  }

  insuranceInfo() {
    return Column(
      children: [
        textFieldStyle(
            context: context,
            edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
            lbTxt: 'Your Insurance Number',
            //controller: emailController,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next),
        textFieldStyle(
            context: context,
            edgeInsetsGeometry: const EdgeInsets.only(bottom: 10),
            lbTxt: 'Your Id Number',
            //  controller: emailController,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next),
        lightBlueBtn('Confirm appointment', const EdgeInsets.all(20), () {
          confirmAppointment();
        }),
      ],
    );
  }
}