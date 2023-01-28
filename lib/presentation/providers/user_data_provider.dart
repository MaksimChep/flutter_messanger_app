import 'package:flutter/widgets.dart';
import 'package:flutter_messenger_app/data/models/user_data_entity.dart';
import 'package:flutter_messenger_app/domain/user%20data/create_user_uc.dart';
import 'package:flutter_messenger_app/domain/user%20data/get_contacts_information_uc.dart';
import 'package:flutter_messenger_app/domain/user%20data/get_user_information_uc.dart';
import 'package:flutter_messenger_app/domain/user%20data/user_exists_uc.dart';

class UserDataProvider with ChangeNotifier {
  final CreateUserUC _createUserUC;
  final GetUserInformationUC _getUserInformationUC;
  final UserExistsUC _userExistsUC;
  final GetContactsInformationUC _getContactsInformationUC;

  UserDataProvider(this._createUserUC, this._getUserInformationUC,
      this._userExistsUC, this._getContactsInformationUC);

  bool _exists = false;
  UserData _userData = UserData(
      id: '',
      name: '',
      surname: '',
      phoneNumber: '',
      profileImage: '',
      contacts: List.empty());
  List<UserData> _contacts = List.empty();
  String _errorMessage = '';

  bool get exists => _exists;
  UserData get userData => _userData;
  List<UserData> get contacts => _contacts;
  String get errorMessage => _errorMessage;

  void createUser(String name, String surname, String phoneNumber,
      String profileImage) async {
    try {
      await _createUserUC(name, surname, phoneNumber, profileImage);
      _resetErrorMessage();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future getUserInformation() async {
    try {
      _userData = await _getUserInformationUC();
      _resetErrorMessage();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future userExists() async {
    try {
      _exists = await _userExistsUC();
      _resetErrorMessage();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future getContactsInformation() async {
    try {
      _contacts = await _getContactsInformationUC();
      _resetErrorMessage();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void _resetErrorMessage() {
    _errorMessage = "";
  }
}
