import 'dart:convert';

FormDataModel formDataFromJson(String str) => FormDataModel.fromJson(json.decode(str));

class FormDataModel {
  List<String> gender;
  List<String> religion;
  List<String> bank;

  FormDataModel({
      required this.gender,
      required this.religion,
      required this.bank,
  });

  factory FormDataModel.fromJson(Map<String, dynamic> json) => FormDataModel(
      gender: List<String>.from(json["gender"].map((x) => x)),
      religion: List<String>.from(json["religion"].map((x) => x)),
      bank: List<String>.from(json["bank"].map((x) => x)),
  );
}

