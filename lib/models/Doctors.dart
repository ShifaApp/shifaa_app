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
  }) {
    _fees = fees;
    _hospitalName = hospitalName;
    _image = image;
    _email = email;
    _hospitalId = hospitalId;
    _name = name;
    _phone = phone;
    _id = id;
    _specialist = specialist;
  }

  Doctors.fromJson(dynamic json) {
    if (json != null) {
      _fees = json['fees'];
      _image = json['image'];
      _name = json['name'];
      _phone = json['phone'];
      _email = json['email'];
      _hospitalName = json['hospitalName'];
      _hospitalId = json['hospitalId'];
      _specialist = json['specialist'];
      _id = json['doctorId'];
    }
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

  String? get fees => _fees;
  String? get image => _image;
  String? get name => _name;
  String? get phone => _phone;
  String? get doctorId => _id;

  String? get hospitalId => _hospitalId;
  String? get hospitalName => _hospitalName;

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
    };
  }
}
