import 'dart:io';

import 'package:url_launcher/url_launcher.dart';


//--------------
void directToPhoneCall(String number) async {

  final Uri launchUri = Uri(
    scheme: 'tel',
    path: number,
  );


  if (await canLaunch(launchUri.toString())) {
    await launch(launchUri.toString());
  } else {
    throw 'Could not launch $launchUri';
  }
}

//--------------

