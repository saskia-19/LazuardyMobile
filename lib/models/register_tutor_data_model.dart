import 'package:image_picker/image_picker.dart';

class RegisterTutorDataModel {
  String email;
  String password;
  String confirmPassword;
  String? name;
  String? gender;
  DateTime? dateOfBirth;
  String? telephoneNumber;
  String? religion;

  String? province;
  String? regency;
  String? district;
  String? subdistrict;
  String? street;
  double? latitude;
  double? longitude;

  // tutor
  String? bank;
  String? rekening;

  XFile? photoProfile;

  RegisterTutorDataModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.telephoneNumber,
    this.photoProfile,
    this.religion,

    this.province,
    this.regency,
    this.district,
    this.subdistrict,
    this.street,
    this.latitude,
    this.longitude,
    
    this.bank,
    this.rekening,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'password_confirmation': confirmPassword,
    'name': name,
    'gender': gender,
    'date_of_birth': dateOfBirth!.toIso8601String(),
    'telephone_number': telephoneNumber,
    'religion': religion,
    'province': province,
    'regency': regency,
    'district': district,
    'subdistrict': subdistrict,
    'street': street,
    'latitude': latitude,
    'longitude': longitude,
    'bank': bank,
    'rekening': rekening,
  };
}
