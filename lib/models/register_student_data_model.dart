import 'package:image_picker/image_picker.dart';

class RegisterStudentDataModel {
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
  String? latitude;
  String? longitude;

  // student
  String? school;
  String? gradeLevel;
  String? parent;
  String? parentTelephoneNumber;

  XFile? photoProfile;
  RegisterStudentDataModel({
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
    this.latitude,
    this.longitude,

    this.school,
    this.gradeLevel,
    this.parent,
    this.parentTelephoneNumber,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'password_confirmation': confirmPassword,
    'name': name,
    'gender': gender,
    'date_of_birth': dateOfBirth,
    'telephone_number': telephoneNumber,
    'religion': religion,
    'province': province,
    'regency': regency,
    'district': district,
    'subdistrict': subdistrict,
    'street': street,
    'latitude': latitude,
    'longitude': longitude,
    'school': school,
    'grade_level': gradeLevel,
    'parent': parent,
    'parent_telephone_number': parentTelephoneNumber,
  };
}