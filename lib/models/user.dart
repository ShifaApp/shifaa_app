import 'package:firebase_auth/firebase_auth.dart';
import 'package:shifa_app_flutter/const/const.dart';
import '../../models/Appointemnts.dart';
import 'Recipe.dart';

class MyUser {

 String name='' , email='',bloodType='';
List<Appointments> myVisits =[];
List<Recipe> myRecipes =[];


addVisit(Appointments appointments){
 myVisits.add(appointments);
}
 MyUser({ this.name='',  this.email='',this.bloodType=''});

 Map<String,dynamic> toMap(){
  return {
   "name":name,
   "email":email,
   "bloodType":bloodType,

  };
 }

 Map<String,dynamic> toJson() =>{

   appointments:myVisits,
   //"email":email,

  };
 MyUser.fromJson(dynamic json) {

  bloodType = json['bloodType'] ?? '';
  email = json['email'] ?? ' ';
  name = json['name']?? '';

 }
//
// User.fromJson(dynamic json) {
//
//   name = json['name'];
//   email = json['email'];
// //  myVisits = json['myVisits'] != null ? Visits.fromJson(json['myVisits']) : null;
//  // myRecipes = json['myRecipes'] != null ? Recipes.fromJson(json['myRecipes']) : null;
// }
}