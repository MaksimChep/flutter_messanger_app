import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    required this.id,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.profileImage,
    required this.contacts,
  });

  final String id;
  final String name;
  final String surname;
  final String phoneNumber;
  final String profileImage;
  final List<String> contacts;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        phoneNumber: json["phoneNumber"],
        profileImage: json["profileImage"],
        contacts: List<String>.from(json["contacts"].map((x) => x)),
      );

  factory UserData.fromFirestore(DocumentSnapshot snapshot) {
    var food = UserData.fromJson(snapshot.data() as Map<String, dynamic>);
    return food;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "phoneNumber": phoneNumber,
        "profileImage": profileImage,
        "contacts": List<dynamic>.from(contacts.map((x) => x)),
      };
}
