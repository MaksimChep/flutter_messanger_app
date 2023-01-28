import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/presentation/providers/auth_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/chat_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/country_code_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/image_storage_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/phone_validator_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/shared_preferences_provider.dart';
import 'package:flutter_messenger_app/presentation/providers/user_data_provider.dart';
import 'package:flutter_messenger_app/presentation/screens/home/home_screen.dart';
import 'package:flutter_messenger_app/presentation/screens/walkthrough_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: ((context) =>
                GetIt.I<CountryCodeProvider>()..getCountryCodes())),
        ChangeNotifierProvider(
            create: ((context) => GetIt.I<PhoneValidatorProvider>())),
        ChangeNotifierProvider(create: ((context) => GetIt.I<AuthProvider>())),
        ChangeNotifierProvider(
            create: ((context) => GetIt.I<UserDataProvider>())),
        ChangeNotifierProvider(
            create: ((context) => GetIt.I<SharedPreferencesProvider>())),
        ChangeNotifierProvider(
            create: ((context) => GetIt.I<ImageStorageProvider>())),
        ChangeNotifierProvider(create: ((context) => GetIt.I<ChatProvider>()))
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Builder(
            builder: (context) {
              final sharedPreferencesProvider =
                  Provider.of<SharedPreferencesProvider>(context,
                      listen: false);
              return FutureBuilder(
                future: sharedPreferencesProvider.getUid(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      {
                        if (sharedPreferencesProvider.uid != '') {
                          return const MultiMainScreen();
                        }
                        return WalkthroughScreen();
                      }

                    default:
                      return const CircularProgressIndicator();
                  }
                },
              );
            },
          )),
    );
  }
}
