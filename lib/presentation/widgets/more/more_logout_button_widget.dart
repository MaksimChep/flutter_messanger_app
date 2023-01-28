import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/presentation/providers/shared_preferences_provider.dart';
import 'package:flutter_messenger_app/presentation/screens/walkthrough_screen.dart';
import 'package:provider/provider.dart';

class MoreLogoutButtonWidget extends StatelessWidget {
  const MoreLogoutButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharedPreferencesProvider =
        Provider.of<SharedPreferencesProvider>(context, listen: false);
    return GestureDetector(
        onTap: () {
          sharedPreferencesProvider.setUid('');
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => WalkthroughScreen()));
        },
        child: const Text('Logout'));
  }
}
