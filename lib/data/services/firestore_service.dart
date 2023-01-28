import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_messenger_app/data/models/user_data_entity.dart';
import 'package:flutter_messenger_app/data/services/shared_preferences_service.dart';

class FirestoreService {
  final _firebaseFirestore = FirebaseFirestore.instance;
  final SharedPreferencesService _sharedPreferencesService;

  FirestoreService(this._sharedPreferencesService);
  String? uid;

  Future<void> createUser(String name, String surname, String phoneNumber,
      String profileImage) async {
    uid = await _sharedPreferencesService.getUid();
    if (uid == null) {
      throw "SharedPreferences variable is null!";
    } else {
      UserData user = UserData(
          id: uid!,
          name: name,
          surname: surname,
          phoneNumber: phoneNumber,
          profileImage: profileImage,
          contacts: List.empty());
      await _firebaseFirestore.collection('users').doc(uid).set(user.toJson());

      await _firebaseFirestore.collection(uid!).doc('emptyDoc').set({});
    }
  }

  Future<UserData> getUserInformation() async {
    if (uid == null) {
      throw "SharedPreferences variable is null!";
    } else {
      UserData user = UserData(
          id: "",
          name: "",
          surname: "",
          phoneNumber: "",
          profileImage: "",
          contacts: List.empty());
      await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .get()
          .then((snapshot) => user = UserData.fromFirestore(snapshot));
      return user;
    }
  }

  Future<bool> userExists() async {
    uid = await _sharedPreferencesService.getUid();
    if (uid == null) {
      throw "SharedPreferences variable is null!";
    } else {
      bool exist = false;
      await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .get()
          .then((value) => value.exists ? exist = true : exist = false);
      return exist;
    }
  }

  Future<List<String>> _getContacts() async {
    uid = await _sharedPreferencesService.getUid();
    UserData user = await getUserInformation();
    List<String> contacts = user.contacts;
    return contacts;
  }

  Future<List<UserData>> getContactsInformation() async {
    List<String> contacts = await _getContacts();
    List<UserData> contactsData = List.empty(growable: true);

    for (var element in contacts) {
      await _firebaseFirestore
          .collection('users')
          .doc(element)
          .get()
          .then((snapshot) {
        contactsData.add(UserData.fromFirestore(snapshot));
      });
    }
    return contactsData;
  }

  Future<UserData> getInterlocutorData(String interlocutorId) async {
    UserData interlocutorData = UserData(
        id: "",
        name: "",
        surname: "",
        phoneNumber: "",
        profileImage: "",
        contacts: List.empty());

    await _firebaseFirestore
        .collection('users')
        .doc(interlocutorId)
        .get()
        .then((snapshot) {
      interlocutorData = UserData.fromFirestore(snapshot);
    });
    return interlocutorData;
  }
}
