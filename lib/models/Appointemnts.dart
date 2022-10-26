/// completed : true
/// date : "12-1-2020 12:30 am"
/// doctor_name : "Ali"
/// hospital_name : "alhabib"

class Appointments {
  Appointments(
      {bool? completed,
      String? date,
      String? doctorName,
      String? paymentType,
      String? hospitalName,
      String? patientName,
      String? patientId,
      String? doctorId,
      String? appointmentType}) {
    _completed = completed;
    _date = date;
    _patientName = patientName;
    _doctorName = doctorName;
    _hospitalName = hospitalName;
    _paymentType = paymentType;
    _patientId = patientId;
    _doctorId = doctorId;
    _type = appointmentType;
  }

  Appointments.fromJson(dynamic json) {
    _completed = json['completed'];
    _date = json['date'];
    _doctorName = json['doctor_name'];
    _hospitalName = json['hospital_name'];
    _paymentType = json['payment_type'];
    _patientName = json['patient_name'];
    _patientId = json['patient_id'];
    _doctorId = json['doctor_id'];

    _type = json['appointment_type'];
  }
  bool? _completed;
  String? _date;
  String? _doctorName;
  String? _doctorId;

  String? _hospitalName;
  String? _paymentType;
  String? _patientName;
  String? _type;
  String? _patientId;

  bool? get reserved => _completed;
  String? get date => _date;
  String? get doctorName => _doctorName;
  String? get hospitalName => _hospitalName;
  String? get paymentType => _paymentType;
  String? get patientName => _patientName;
  String? get appointmentType => _type;
  String? get patientId => _patientId;
  String? get doctorId => _doctorId;

  setPatientName(String patientName){
    _patientName = patientName;
  }
  setPatientId(String patientId){
    _patientId = patientId;
  }
  Map<String, dynamic> toMap() {
    return {
      "completed": _completed,
      'date': _date,
      'doctor_name': _doctorName,
      'appointment_type': _type,
      'hospital_name': _hospitalName,
      'paymentType': _paymentType,
      'patientName': _patientName,
      'patientId': _patientId,
      'doctor_id': _doctorId,
    };
  }
}
