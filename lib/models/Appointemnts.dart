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
      String? hospitalId,
      String? patientName,
      String? patientId,
      String? doctorId,
        bool? reserved,
      String? appointmentType}) {
    _completed = completed;
    _date = date;
    _patientName = patientName;
    _doctorName = doctorName;
    _hospitalId = hospitalId;
    _hospitalName = hospitalName;
    _paymentType = paymentType;
    _patientId = patientId;
    _doctorId = doctorId;
    _type = appointmentType;
    _reserved =reserved;
  }

  Appointments.fromJson(dynamic json) {
    _completed = json['completed'];
    _date = json['date'];
    _doctorName = json['doctor_name'];
    _hospitalName = json['hospital_name'];
    _paymentType = json['paymentType'];
    _patientName = json['patientName'];
    _patientId = json['patientId'];
    _doctorId = json['doctor_id'];
    _hospitalId = json['hospital_id'];
    _type = json['appointment_type'];
    _reserved =json['reserved'];
    // return Appointments( completed:  json["completed"]  ,
    //   date : json['date'],
    //   doctorName : json['doctor_name'],
    //   hospitalName : json['hospital_name'],
    //   paymentType : json['payment_type'],
    //   patientName : json['patient_name'],
    //   patientId : json['patient_id'],
    //   doctorId : json['doctor_id'],
    //   hospitalId : json['hospital_id'],
    //
    //   appointmentType : json['appointment_type'],);

  }
  bool? _completed;
  String? _date;
  String? _doctorName;
  String? _doctorId;
  bool? _reserved;

  String? _hospitalName;
  String? _paymentType;
  String? _patientName;
  String? _type;
  String? _patientId;
  String? _hospitalId;

  bool? get reserved=> _reserved;
  bool? get completed => _completed;
  String? get date => _date;
  String? get doctorName => _doctorName;
  String? get hospitalName => _hospitalName;
  String? get paymentType => _paymentType;
  String? get patientName => _patientName;
  String? get appointmentType => _type;
  String? get patientId => _patientId;
  String? get doctorId => _doctorId;
  String? get hospitalId => _hospitalId;

  setPatientName(String patientName) {
    _patientName = patientName;
  }
  setPaymentType(String pay) {
    _paymentType = pay;
  }
  setPatientId(String patientId) {
    _patientId = patientId;
  }

  setReserved(bool  value) {
    _reserved = value;
  }
  setCompleted(bool  value) {
    _completed = value;
  }

  Map<String, dynamic> toMap() {
    return {
      "reserved":_reserved,
      "completed": _completed,
      'date': _date,
      'doctor_name': _doctorName,
      'appointment_type': _type,
      'hospital_name': _hospitalName,
      'paymentType': _paymentType,
      'patientName': _patientName,
      'patientId': _patientId,
      'doctor_id': _doctorId,
      'hospital_id': _hospitalId,
    };
  }
}
