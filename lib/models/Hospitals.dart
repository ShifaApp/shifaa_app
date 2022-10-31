import 'Appointemnts.dart';
import 'Doctors.dart';

/// Doctors : [{"fees":100,"image":"https://firebasestorage.googleapis.com/v0/b/shifaapp-b19ca.appspot.com/o/images%2Fdr.jpeg?alt=media&token=c82a8e38-179c-4238-b589-7497198aa9c0","name":"Mohammed Ali","phone":966541227860,"specialist":"general "}]
/// address : "Reiyadah - 21188 street"
/// image : "https://firebasestorage.googleapis.com/v0/b/shifaapp-b19ca.appspot.com/o/images%2Falhabib.jpeg?alt=media&token=b59f0629-47b9-4a41-a2fb-b9199152d909"
/// name : "ALhabib Hospital"
/// phone : 996541227860

class Hospitals {
  Hospitals({
    List<Doctors>? doctors,
    String? address,
    String? id,
    String? image,
    String? name,
    String? email,
    String? phone,
    bool? accepted,
  }) {
    _doctors = doctors;
    _address = address;
    _image = image;
    _id = id;
    _accepted = accepted;
    _name = name;
    _email = email;
    _phone = phone;
  }

  Hospitals.fromJson(dynamic json) {
    if (json != null) {
      // if (json['Doctors'] != null) {
      //   _doctors = [];
      //   json['Doctors'].forEach((v) {
      //     _doctors?.add(Doctors.fromJson(v));
      //   });
      // }
      //  _doctors = json['Doctors'] ;
      _address = json['address'];
      _image = json['image'];
      _name = json['name'];
      _email = json['email'];
      _accepted = json['accepted'];
      _phone = json['phone'];
      _id = json['hospitalId'];
    }
    // return Hospitals(
    //     address : json['address'],
    //     image : json['image'],
    //     name : json['name'],
    // email : json['email'],
    // accepted : json['accepted'],
    // phone : json['phone'],
    // id : json['hospitalId'],doctors: Doctors.fromJson(json['Doctors']) as List<Doctors>
    // );
    //   if (json['Doctors'] != null) {
    //     _doctors = [];
    //     List<Appointments> appointments = [];
    //     if (json['appointments'] != null) {
    //
    //       json['appointments'].forEach((v) {
    //         appointments.add(Appointments( completed:  json["completed"]  ,
    //           date : json['date'],
    //           doctorName : json['doctor_name'],
    //           hospitalName : json['hospital_name'],
    //           paymentType : json['payment_type'],
    //           patientName : json['patient_name'],
    //           patientId : json['patient_id'],
    //           doctorId : json['doctor_id'],
    //           hospitalId : json['hospital_id'],
    //
    //           appointmentType : json['appointment_type'],));
    //       });
    //     }
    //     json['Doctors'].forEach((v) {
    //       _doctors?.add(Doctors(      fees : json['fees'],
    //          image :json['image'],
    //           name : json['name'],
    //           phone : json['phone'],
    //           email : json['email'],
    //           hospitalName : json['hospitalName'],
    //           hospitalId : json['hospitalId'],
    //           specialist : json['specialist'],
    //           id : json['doctorId'],appointments: appointments
    //         ));
    //     });
    //   }
    //
    // //  _doctors = json['Doctors'] ;
    //   _address = json['address'];
    //   _image = json['image'];
    //   _name = json['name'];
    //   _email = json['email'];
    //   _accepted = json['accepted'];
    //   _phone = json['phone'];
    //   _id = json['hospitalId'];
  }
  List<Doctors>? _doctors;
  String? _address;
  String? _image;
  String? _name;
  String? _email;
  bool? _accepted;
  String? _phone;
  String? _id;

  List<Doctors>? get doctors => _doctors;
  String? get address => _address;
  String? get image => _image;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  bool? get accepted => _accepted;
  String? get hospitalId => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_doctors != null) {
      map['Doctors'] = _doctors?.map((v) => v.toJson()).toList();
    }
    map['address'] = _address;
    map['email'] = _email;
    map['image'] = _image;
    map['name'] = _name;
    map['phone'] = _phone;
    map['accepted'] = _accepted;
    map['hospitalId'] = _id;

    return map;
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      'address': _address,
      'image': _image,
      'phone': _phone,
      'hospitalId': _id,
      'Doctors': _doctors,
      'accepted': _accepted,
    };
  }

  @override
  String toString() {
    return 'Hospitals{_doctors: $_doctors, _address: $_address, _image: $_image, _name: $_name, _phone: $_phone}';
  }
}
