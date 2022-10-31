
import '../../models/Appointemnts.dart';
import 'Recipe.dart';

class MyUser {
  String? _id,
      _name,
      _email,
      _bloodType,
      _insuranceId,
      _birthOfDate,
      _address,
      _sex,
      _phone;
  List<Appointments>? _appointments;
  List<Recipe>? _myRecipes;

  addVisit(Appointments appointments) {
    _appointments!.add(appointments);
  }

  MyUser({
    String? address,
    String? phone,
    String? name,
    String? sex,
    String? email,
    String? insuranceId,
    String? bloodType,
    String? id,
    String? birthDate,
    List<Appointments>? appointments,
    List<Recipe>? recipes,
  }) {
    _address = address;
    _sex = sex;
    _insuranceId = insuranceId;
    _email = email;
    _birthOfDate = birthDate;
    _name = name;
    _phone = phone;
    _id = id;
    _bloodType = bloodType;
    _appointments = appointments;
    _myRecipes = recipes;
  }
  Map<String, dynamic> toMap() {
    return {
      "id": _id,
      "name": _name,
      "email": _email,
      "bloodType": _bloodType,
      'insurance_id': _insuranceId,
      'birth_date': _birthOfDate,
      'address': _address,
      'phone': _phone,
      'sex': _sex,
    };
  }

  MyUser.fromJson(dynamic json) {
    _id = json['id'] ?? '';
    _bloodType = json['bloodType'] ?? '';
    _email = json['email'] ?? ' ';
    _name = json['name'] ?? '';
    _insuranceId = json['insurance_id'] ?? '';
    _birthOfDate = json['birth_date'] ?? '';
    _address = json['address'] ?? '';
    _phone = json['phone'] ?? '';
    _sex = json['sex'] ?? '';
  }

  List<Recipe>? get myRecipes => _myRecipes;

  List<Appointments>? get appointments => _appointments;

  String? get phone => _phone;

  String? get sex => _sex;

  String? get address => _address;

  String? get birthOfDate => _birthOfDate;

  String? get insuranceId => _insuranceId;

  String? get bloodType => _bloodType;

  String? get email => _email;

  String? get name => _name;

  String? get id => _id;

//
// User.fromJson(dynamic json) {
//
//   name = json['name'];
//   email = json['email'];
// //  myVisits = json['myVisits'] != null ? Visits.fromJson(json['myVisits']) : null;
//  // myRecipes = json['myRecipes'] != null ? Recipes.fromJson(json['myRecipes']) : null;
// }
}
