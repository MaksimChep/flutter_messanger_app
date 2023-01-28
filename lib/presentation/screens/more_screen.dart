import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/presentation/widgets/more/more_logout_button_widget.dart';
import 'package:flutter_messenger_app/presentation/widgets/more/more_user_info_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          MoreUserInfoWidget(),
          SizedBox(height: 16.0),
          MoreLogoutButtonWidget()
        ],
      ),
    ));
  }
}
