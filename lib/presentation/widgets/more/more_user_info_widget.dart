import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/data/models/user_data_entity.dart';
import 'package:flutter_messenger_app/presentation/providers/user_data_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MoreUserInfoWidget extends StatelessWidget {
  const MoreUserInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FutureBuilder(
        future: userDataProvider.getUserInformation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          UserData userData = userDataProvider.userData;
          return Row(
            children: [
              SizedBox(
                  height: 80.0,
                  width: 80.0,
                  child: userData.profileImage.isEmpty
                      ? SvgPicture.asset(
                          'assets/images/changeAvatar.svg',
                          fit: BoxFit.fill,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: Image.network(
                              userDataProvider.userData.profileImage))),
              const SizedBox(width: 20.0),
              SizedBox(
                height: 80.0,
                child: Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${userData.name} ${userData.surname}'),
                      Text(userData.phoneNumber)
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
