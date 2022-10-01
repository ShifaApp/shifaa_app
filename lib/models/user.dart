import 'package:firebase_auth/firebase_auth.dart';
import 'Recipes.dart';
import 'Visits.dart';

class MyUser {

 String name , email;
List<Visits> myVisits =[];
List<Recipes> myRecipes =[];

 MyUser({required this.name, required this.email});

 Map<String,dynamic> toMap(){
  return {
   "name":name,
   "email":email,

  };
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