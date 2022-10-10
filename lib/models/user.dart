import 'package:firebase_auth/firebase_auth.dart';
import 'package:shifa_app_flutter/const/const.dart';
import 'Recipes.dart';
import '../../models/Appointemnts.dart';

class MyUser {

 String name , email;
List<Appointments> myVisits =[];
List<Recipes> myRecipes =[];


addVisit(Appointments appointments){
 myVisits.add(appointments);
}
 MyUser({ this.name='',  this.email=''});

 Map<String,dynamic> toMap(){
  return {
   "name":name,
   "email":email,

  };
 }

 Map<String,dynamic> toJson() =>{

   appointments:myVisits,
   //"email":email,

  };

//
// User.fromJson(dynamic json) {
//
//   name = json['name'];
//   email = json['email'];
// //  myVisits = json['myVisits'] != null ? Visits.fromJson(json['myVisits']) : null;
//  // myRecipes = json['myRecipes'] != null ? Recipes.fromJson(json['myRecipes']) : null;
// }
}