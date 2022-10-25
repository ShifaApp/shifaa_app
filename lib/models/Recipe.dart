/// appointment_date : "111"
/// appointment_type : "111"
/// patient_name : ""
/// patient_id : ""
/// doctor_name : ""
/// diagnosis : ""
/// recipe : ""

class Recipe {
  Recipe({
      String? appointmentDate, 
      String? appointmentType, 
      String? patientName, 
      String? patientId, 
      String? doctorName, 
      String? diagnosis, 
      String? recipe,}){
    _appointmentDate = appointmentDate;
    _appointmentType = appointmentType;
    _patientName = patientName;
    _patientId = patientId;
    _doctorName = doctorName;
    _diagnosis = diagnosis;
    _recipe = recipe;
}

  Recipe.fromJson(dynamic json) {
    _appointmentDate = json['appointment_date'];
    _appointmentType = json['appointment_type'];
    _patientName = json['patient_name'];
    _patientId = json['patient_id'];
    _doctorName = json['doctor_name'];
    _diagnosis = json['diagnosis'];
    _recipe = json['recipe'];
  }
  String? _appointmentDate;
  String? _appointmentType;
  String? _patientName;
  String? _patientId;
  String? _doctorName;
  String? _diagnosis;
  String? _recipe;

  String? get appointmentDate => _appointmentDate;
  String? get appointmentType => _appointmentType;
  String? get patientName => _patientName;
  String? get patientId => _patientId;
  String? get doctorName => _doctorName;
  String? get diagnosis => _diagnosis;
  String? get recipe => _recipe;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appointment_date'] = _appointmentDate;
    map['appointment_type'] = _appointmentType;
    map['patient_name'] = _patientName;
    map['patient_id'] = _patientId;
    map['doctor_name'] = _doctorName;
    map['diagnosis'] = _diagnosis;
    map['recipe'] = _recipe;
    return map;
  }
  Map<String, dynamic> toMap() {
    return {
    'appointment_date':_appointmentDate,
    'appointment_type':_appointmentType,
    'patient_name':_patientName,
    'patient_id':_patientId,
    'doctor_name':_doctorName,
    'diagnosis':_diagnosis,
    'recipe':_recipe,
    };
  }
}