import 'package:flutter_messenger_app/data/models/user_data_entity.dart';
import 'package:flutter_messenger_app/data/repository/user_data_repository.dart';
import 'package:flutter_messenger_app/data/services/firestore_service.dart';

class UserDataRepositoryImpl extends UserDataRepository {
  final FirestoreService _firestoreService;

  UserDataRepositoryImpl(this._firestoreService);

  @override
  Future<void> createUser(String name, String surname, String phoneNumber,
      String profileImage) async {
    await _firestoreService.createUser(
        name, surname, phoneNumber, profileImage);
  }

  @override
  Future<UserData> getUserInformation() async {
    UserData user = await _firestoreService.getUserInformation();
    return user;
  }

  @override
  Future<bool> userExists() async {
    bool exist = await _firestoreService.userExists();
    return exist;
  }

  @override
  Future<List<UserData>> getContactsInformation() async {
    List<UserData> contacts = await _firestoreService.getContactsInformation();
    return contacts;
  }
}
