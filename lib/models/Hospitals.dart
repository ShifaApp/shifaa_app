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
      String? image, 
      String? name, 
      int? phone,}){
    _doctors = doctors;
    _address = address;
    _image = image;
    _name = name;
    _phone = phone;
}

  Hospitals.fromJson(dynamic json) {
    if (json['Doctors'] != null) {
      _doctors = [];
      json['Doctors'].forEach((v) {
        _doctors?.add(Doctors.fromJson(v));
      });
    }
    _address = json['address'];
    _image = json['image'];
    _name = json['name'];
    _phone = json['phone'];
  }
  List<Doctors>? _doctors;
  String? _address;
  String? _image;
  String? _name;
  int? _phone;

  List<Doctors>? get doctors => _doctors;
  String? get address => _address;
  String? get image => _image;
  String? get name => _name;
  int? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_doctors != null) {
      map['Doctors'] = _doctors?.map((v) => v.toJson()).toList();
    }
    map['address'] = _address;
    map['image'] = _image;
    map['name'] = _name;
    map['phone'] = _phone;
    return map;
  }

  @override
  String toString() {
    return 'Hospitals{_doctors: $_doctors, _address: $_address, _image: $_image, _name: $_name, _phone: $_phone}';
  }
}

