// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int status;
  String message;
  Data data;

  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String firstName;
  String lastName;
  String middleInitial;
  String suffix;
  String sex;
  String email;
  String username;
  String contactNo;
  String unitSt;
  String barangayId;
  String barangay;
  String municipality;
  String province;
  String region;
  String picture;
  DateTime bday;
  dynamic idPicture;

  Data({
    required this.firstName,
    required this.lastName,
    required this.middleInitial,
    required this.suffix,
    required this.sex,
    required this.email,
    required this.username,
    required this.contactNo,
    required this.unitSt,
    required this.barangayId,
    required this.barangay,
    required this.municipality,
    required this.province,
    required this.region,
    required this.picture,
    required this.bday,
    this.idPicture,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleInitial: json["middle_initial"],
        suffix: json["suffix"],
        sex: json["sex"],
        email: json["email"],
        username: json["username"],
        contactNo: json["contact_no"],
        unitSt: json["unit_st"],
        barangayId: json["barangay_id"],
        barangay: json["barangay"],
        municipality: json["municipality"],
        province: json["province"],
        region: json["region"],
        picture: json["picture"],
        bday: DateTime.parse(json["bday"]),
        idPicture: json["id_picture"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "middle_initial": middleInitial,
        "suffix": suffix,
        "sex": sex,
        "email": email,
        "username": username,
        "contact_no": contactNo,
        "unit_st": unitSt,
        "barangay_id": barangayId,
        "barangay": barangay,
        "municipality": municipality,
        "province": province,
        "region": region,
        "picture": picture,
        "bday":
            "${bday.year.toString().padLeft(4, '0')}-${bday.month.toString().padLeft(2, '0')}-${bday.day.toString().padLeft(2, '0')}",
        "id_picture": idPicture,
      };
}
