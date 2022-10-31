import 'Appointemnts.dart';

/// fees : 100
/// image : "https://firebasestorage.googleapis.com/v0/b/shifaapp-b19ca.appspot.com/o/images%2Fdr.jpeg?alt=media&token=c82a8e38-179c-4238-b589-7497198aa9c0"
/// name : "Mohammed Ali"
/// phone : 966541227860
/// specialist : "general "

class Doctors {
  Doctors({
    String? fees,
    String? image,
    String? name,
    String? phone,
    String? email,
    String? hospitalId,
    String? hospitalName,
    String? id,
    String? specialist,
    List<Appointments>? appointments,
  }) {
    _fees = fees;
    _hospitalName = hospitalName;
    _image = image;
    _email = email;
    _hospitalId = hospitalId;
    _name = name;
    _phone = phone;
    _id = id;
    _appointments = appointments;
    _specialist = specialist;
  }

   Doctors.fromJson(dynamic json) {
    if(json != null){
      // if (json['appointments'] != null) {
      //   _appointments = [];
      //   json['appointments'].forEach((v) {
      //     _appointments?.add(Appointments.fromJson(v));
      //   });
      // }

      _image =json['image'];
      _name = json['name'];
      _phone = json['phone'];
      _email = json['email'];
      _hospitalName = json['hospitalName'];
      _hospitalId = json['hospitalId'];
      _specialist = json['specialist'];
      _id = json['doctorId'];
      _fees = json['fees'];
    }

   // print(json['appointments'] .cast<String,dynamic>());
  //  Iterable l = json['appointments'] .cast<String,dynamic>();//json.decode(json['appointments']);
  //   List<Appointments> posts = List<Appointments>.from(json['appointments'] .map((model)=> Appointments.fromJson(model)));
  //  return Doctors( fees : json['fees'],
  //      image :json['image'],
  //      name : json['name'],
  //      phone : json['phone'],
  //      email : json['email'],
  //      hospitalName : json['hospitalName'],
  //      hospitalId : json['hospitalId'],
  //      specialist : json['specialist'],
  //      id : json['doctorId'],appointments: posts
  //
  //
  // // if (json != null) {
  // //    _fees = json['fees'];
  // //    _image = json['image'];
  // //    _name = json['name'];
  // //    _phone = json['phone'];
  // //    _email = json['email'];
  // //    _hospitalName = json['hospitalName'];
  // //    _hospitalId = json['hospitalId'];
  // //    _specialist = json['specialist'];
  // //    _id = json['doctorId'];
  // //    //List<Appointments>.from(json["appointments"].map((x) => x));
  // //    if (json['appointments'] != null) {
  // //      _appointments = [];
  // //      json['appointments'].forEach((v) {
  // //        _appointments?.add(Appointments(
  // //          completed: json["completed"],
  // //          date: json['date'],
  // //          doctorName: json['doctor_name'],
  // //          hospitalName: json['hospital_name'],
  // //          paymentType: json['payment_type'],
  // //          patientName: json['patient_name'],
  // //          patientId: json['patient_id'],
  // //          doctorId: json['doctor_id'],
  // //          hospitalId: json['hospital_id'],
  // //          appointmentType: json['appointment_type'],
  // //        ));
  // //      });
  // //    }
  // //  }
  //  );
  }
  String? _fees;
  String? _image;
  String? _name;
  String? _email;
  String? _hospitalId;
  String? _hospitalName;
  String? _phone;
  String? _specialist;
  String? _id;
  List<Appointments>? _appointments;

  String? get fees => _fees;
  String? get image => _image;
  String? get name => _name;
  String? get phone => _phone;
  String? get doctorId => _id;

  String? get hospitalId => _hospitalId;
  String? get hospitalName => _hospitalName;
  List<Appointments>? get appointments => _appointments;

  String? get specialist => _specialist;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fees'] = _fees;
    map['image'] = _image;
    map['hospitalName'] = _hospitalName;
    map['email'] = _email;
    map['name'] = _name;
    map['phone'] = _phone;
    map['hospitalId'] = _hospitalId;
    map['doctorId'] = _id;

    map['specialist'] = _specialist;
    return map;
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      'fees': _fees,
      'doctorId': _id,
      'hospitalName': _hospitalName,
      'specialist': _specialist,
      'hospitalId': _hospitalId,
      'image': _image,
      'phone': _phone,
      'appointments': _appointments
    };
  }

  @override
  String toString() {
    return 'Doctors{_name: $_name, _email: $_email, _id: $_id}';
  }
}
