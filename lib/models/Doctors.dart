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
    String? specialist,
  }) {
    _fees = fees;
    _image = image;
    _email = email;
    _name = name;
    _phone = phone;
    _specialist = specialist;
  }

  Doctors.fromJson(dynamic json) {
    if (json != null) {
      _fees = json['fees'];
      _image = json['image'];
      _name = json['name'];
      _phone = json['phone'];
      _email = json['email'];
      _specialist = json['specialist'];
    }
  }
  String? _fees;
  String? _image;
  String? _name;
  String? _email;

  String? _phone;
  String? _specialist;

  String? get fees => _fees;
  String? get image => _image;
  String? get name => _name;
  String? get phone => _phone;
  String? get specialist => _specialist;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fees'] = _fees;
    map['image'] = _image;
    map['email'] = _email;
    map['name'] = _name;
    map['phone'] = _phone;
    map['specialist'] = _specialist;
    return map;
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      'fees' :_fees,
      'specialist' :_specialist,
      'image' : _image,
      'phone' : _phone,
    };
  }
}
