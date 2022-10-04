/// fees : 100
/// image : "https://firebasestorage.googleapis.com/v0/b/shifaapp-b19ca.appspot.com/o/images%2Fdr.jpeg?alt=media&token=c82a8e38-179c-4238-b589-7497198aa9c0"
/// name : "Mohammed Ali"
/// phone : 966541227860
/// specialist : "general "

class Doctors {
  Doctors({
      int? fees, 
      String? image, 
      String? name, 
      int? phone, 
      String? specialist,}){
    _fees = fees;
    _image = image;
    _name = name;
    _phone = phone;
    _specialist = specialist;
}

  Doctors.fromJson(dynamic json) {
    if(json !=null) {
      _fees = json['fees'];
      _image = json['image'];
      _name = json['name'];
      _phone = json['phone'];
      _specialist = json['specialist'];
    }
  }
  int? _fees;
  String? _image;
  String? _name;
  int? _phone;
  String? _specialist;

  int? get fees => _fees;
  String? get image => _image;
  String? get name => _name;
  int? get phone => _phone;
  String? get specialist => _specialist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fees'] = _fees;
    map['image'] = _image;
    map['name'] = _name;
    map['phone'] = _phone;
    map['specialist'] = _specialist;
    return map;
  }

}