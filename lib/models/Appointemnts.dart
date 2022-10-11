/// completed : true
/// date : "12-1-2020 12:30 am"
/// doctor_name : "Ali"
/// hospital_name : "alhabib"

class Appointments {
  Appointments({
      bool? completed, 
      String? date, 
      String? doctorName, 
      String? hospitalName,}){
    _completed = completed;
    _date = date;
    _doctorName = doctorName;
    _hospitalName = hospitalName;
}

  Appointments.fromJson(dynamic json) {
    _completed = json['completed'];
    _date = json['date'];
    _doctorName = json['doctor_name'];
    _hospitalName = json['hospital_name'];
  }
  bool? _completed;
  String? _date;
  String? _doctorName;
  String? _hospitalName;

  bool? get completed => _completed;
  String? get date => _date;
  String? get doctorName => _doctorName;
  String? get hospitalName => _hospitalName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['completed'] = _completed;
    map['date'] = _date;
    map['doctor_name'] = _doctorName;
    map['hospital_name'] = _hospitalName;
    return map;
  }
  Map<String,dynamic> toMap(){
    return {
    "completed": _completed,
   'date': _date,
    'doctor_name': _doctorName,
    'hospital_name': _hospitalName,

    };
  }

}