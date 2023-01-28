import 'package:flutter_messenger_app/data/models/user_data_entity.dart';

abstract class UserDataRepository {
  Future<void> createUser(
      String name, String surname, String phoneNumber, String profileImage);

  Future<UserData> getUserInformation();

  Future<bool> userExists();

  Future<List<UserData>> getContactsInformation();
}
