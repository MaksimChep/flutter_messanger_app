import 'package:flutter_messenger_app/data/repository/auth_repository.dart';
import 'package:flutter_messenger_app/data/repository/auth_repository_impl.dart';
import 'package:flutter_messenger_app/data/repository/chat_repository.dart';
import 'package:flutter_messenger_app/data/repository/chat_repository_impl.dart';
import 'package:flutter_messenger_app/data/repository/country_code_repository.dart';
import 'package:flutter_messenger_app/data/repository/country_code_repository_impl.dart';
import 'package:flutter_messenger_app/data/repository/image_storage_repository.dart';
import 'package:flutter_messenger_app/data/repository/image_storage_repository_impl.dart';
import 'package:flutter_messenger_app/data/repository/phone_validator_repository.dart';
import 'package:flutter_messenger_app/data/repository/phone_validator_repository_impl.dart';
import 'package:flutter_messenger_app/data/repository/shared_preferences_repository.dart';
import 'package:flutter_messenger_app/data/repository/shared_preferences_repository_impl.dart';
import 'package:flutter_messenger_app/data/repository/user_data_repository.dart';
import 'package:flutter_messenger_app/data/repository/user_data_repository_impl.dart';
import 'package:flutter_messenger_app/data/services/auth_service.dart';
import 'package:flutter_messenger_app/data/services/firebase_storage_service.dart';
import 'package:flutter_messenger_app/data/services/firestore_service.dart';
import 'package:flutter_messenger_app/data/services/realtime_database_service.dart';
import 'package:flutter_messenger_app/data/services/shared_preferences_service.dart';
import 'package:flutter_messenger_app/domain/auth/create_user_with_phone_number_uc.dart';
import 'package:flutter_messenger_app/domain/chat/get_all_chats_uc.dart';
import 'package:flutter_messenger_app/domain/chat/get_conversation_stream_uc.dart';
import 'package:flutter_messenger_app/domain/chat/get_conversation_uc.dart';
import 'package:flutter_messenger_app/domain/chat/send_message_uc.dart';
import 'package:flutter_messenger_app/domain/country%20code/get_country_codes_uc.dart';
import 'package:flutter_messenger_app/domain/auth/validate_phone_number_uc.dart';
import 'package:flutter_messenger_app/domain/auth/verify_otp_uc.dart';
import 'package:flutter_messenger_app/domain/image%20storage/add_to_storage_uc.dart';
import 'package:flutter_messenger_app/domain/image%20storage/get_download_url_uc.dart';
import 'package:flutter_messenger_app/domain/shared%20preferences/get_uid_uc.dart';
import 'package:flutter_messenger_app/domain/shared%20preferences/set_uid_uc.dart';
import 'package:flutter_messenger_app/domain/user%20data/create_user_uc.dart';
import 'package:flutter_messenger_app/domain/user%20data/get_contacts_information_uc.dart';
import 'package:flutter_messenger_app/domain/user%20data/get_user_information_uc.dart';
import 'package:flutter_messenger_app/domain/user%20data/user_exists_uc.dart';
import 'package:flutter_messenger_app/presentation/providers/auth_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/chat_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/country_code_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/image_storage_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/phone_validator_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/shared_preferences_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/user_data_provider.dart';
import 'package:get_it/get_it.dart';

final _injector = GetIt.instance;

void setUp() {
  ////////////Shared Preferences////////////
  _injector.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService());

  _injector.registerLazySingleton<SharedPreferencesRepository>(() =>
      SharedPreferencesRepositoryImpl(_injector<SharedPreferencesService>()));

  _injector.registerLazySingleton<GetUidUC>(
      () => GetUidUC(_injector<SharedPreferencesRepository>()));

  _injector.registerLazySingleton<SetUidUC>(
      () => SetUidUC(_injector<SharedPreferencesRepository>()));

  _injector.registerLazySingleton<SharedPreferencesProvider>(() =>
      SharedPreferencesProvider(_injector<GetUidUC>(), _injector<SetUidUC>()));

////////////Country Code////////////
  _injector.registerLazySingleton<CountryCodeRepository>(
      () => CountryCodeRepositoryImpl());

  _injector.registerLazySingleton<GetCountryCodesUC>(
      () => GetCountryCodesUC(_injector<CountryCodeRepository>()));

  _injector.registerLazySingleton<CountryCodeProvider>(
      () => CountryCodeProvider(_injector<GetCountryCodesUC>()));

////////////Phone Validator////////////
  _injector.registerLazySingleton<PhoneValidatorRepository>(
      () => PhoneValidatorRepositoryImpl());

  _injector.registerLazySingleton<ValidatePhoneNumberUC>(
      () => ValidatePhoneNumberUC(_injector<PhoneValidatorRepository>()));

  _injector.registerLazySingleton<PhoneValidatorProvider>(
      () => PhoneValidatorProvider(_injector<ValidatePhoneNumberUC>()));

////////////Auth////////////
  _injector.registerLazySingleton<AuthService>(
      () => AuthService(_injector<SharedPreferencesService>()));

  _injector.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(_injector<AuthService>()));

  _injector.registerLazySingleton<CreateUserWithPhoneNumberUC>(
      () => CreateUserWithPhoneNumberUC(_injector<AuthRepository>()));

  _injector.registerLazySingleton<VerifyOTPUC>(
      () => VerifyOTPUC(_injector<AuthRepository>()));

  _injector.registerLazySingleton<AuthProvider>(() => AuthProvider(
      _injector<CreateUserWithPhoneNumberUC>(), _injector<VerifyOTPUC>()));

////////////User Data////////////
  _injector.registerLazySingleton<FirestoreService>(
      () => FirestoreService(_injector<SharedPreferencesService>()));

  _injector.registerLazySingleton<UserDataRepository>(
      () => UserDataRepositoryImpl(_injector<FirestoreService>()));

  _injector.registerLazySingleton<CreateUserUC>(
      () => CreateUserUC(_injector<UserDataRepository>()));

  _injector.registerLazySingleton<GetUserInformationUC>(
      () => GetUserInformationUC(_injector<UserDataRepository>()));

  _injector.registerLazySingleton<UserExistsUC>(
      () => UserExistsUC(_injector<UserDataRepository>()));

  _injector.registerLazySingleton<GetContactsInformationUC>(
      () => GetContactsInformationUC(_injector<UserDataRepository>()));

  _injector.registerLazySingleton<UserDataProvider>(() => UserDataProvider(
      _injector<CreateUserUC>(),
      _injector<GetUserInformationUC>(),
      _injector<UserExistsUC>(),
      _injector<GetContactsInformationUC>()));

  ////////////Image Storage////////////
  _injector.registerLazySingleton<FirebaseStorageService>(
      () => FirebaseStorageService());

  _injector.registerLazySingleton<ImageStorageRepository>(
      () => ImageStorageRepositoryImpl(_injector<FirebaseStorageService>()));

  _injector.registerLazySingleton<AddToStorageUC>(
      () => AddToStorageUC(_injector<ImageStorageRepository>()));

  _injector.registerLazySingleton<GetDownloadUrlUC>(
      () => GetDownloadUrlUC(_injector<ImageStorageRepository>()));

  _injector.registerLazySingleton<ImageStorageProvider>(() =>
      ImageStorageProvider(
          _injector<AddToStorageUC>(), _injector<GetDownloadUrlUC>()));

  ////////////Chat Info////////////
  _injector.registerLazySingleton<RealtimeDatabaseService>(
      () => RealtimeDatabaseService());

  _injector.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(
      _injector<RealtimeDatabaseService>(), _injector<FirestoreService>()));

  _injector.registerLazySingleton<GetConversationUC>(
      () => GetConversationUC(_injector<ChatRepository>()));

  _injector.registerLazySingleton<SendMessageUC>(
      () => SendMessageUC(_injector<ChatRepository>()));

  _injector.registerLazySingleton<GetConversationStreamUC>(
      () => GetConversationStreamUC(_injector<ChatRepository>()));

  _injector.registerLazySingleton<GetAllChatsUC>(
      () => GetAllChatsUC(_injector<ChatRepository>()));

  _injector.registerLazySingleton<ChatProvider>(() => ChatProvider(
        _injector<GetConversationUC>(),
        _injector<SendMessageUC>(),
        _injector<GetConversationStreamUC>(),
        _injector<GetAllChatsUC>(),
      ));
}
