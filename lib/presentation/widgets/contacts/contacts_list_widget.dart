import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/data/models/user_data_entity.dart';
import 'package:flutter_messenger_app/presentation/providers/user_data_provider.dart';
import 'package:flutter_messenger_app/presentation/screens/specific_chat_screen.dart';
import 'package:provider/provider.dart';

class ContactsList extends StatefulWidget {
  ContactsList({Key? key, required this.filter}) : super(key: key);
  String filter;
  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  late double screenHeight;
  late double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Builder(builder: (context) {
      final userDataProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      return FutureBuilder(
          future: userDataProvider.getContactsInformation(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                {
                  List<UserData> contacts = userDataProvider.contacts.where(
                    (element) {
                      String fullName = '${element.name} ${element.surname}';
                      if (fullName.toLowerCase().contains(widget.filter)) {
                        return true;
                      }
                      return false;
                    },
                  ).toList();
                  return ListView.separated(
                      itemCount: contacts.length,
                      separatorBuilder: ((context, index) {
                        return const Divider();
                      }),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpecificChatScreen(
                                      interlocutorData: contacts[index]))),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.064),
                              child: Row(children: [
                                Container(
                                    height: screenWidth * 0.128,
                                    width: screenWidth * 0.128,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF166FF6),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Builder(builder: (context) {
                                      if (contacts[index].profileImage == '') {
                                        return Center(
                                            child: Text(
                                                contacts[index].name[0] +
                                                    contacts[index].surname[0],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Lato',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        screenHeight * 0.017)));
                                      }
                                      return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.network(
                                              contacts[index].profileImage,
                                              fit: BoxFit.fill));
                                    })),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: screenWidth * 0.032),
                                    child: SizedBox(
                                      width: screenWidth * 0.69,
                                      height: screenWidth * 0.128,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                              '${contacts[index].name} ${contacts[index].surname}',
                                              style: TextStyle(
                                                  fontFamily: 'Mulish',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      screenHeight * 0.017)),
                                        ],
                                      ),
                                    ))
                              ])),
                        );
                      });
                }
              default:
                return Container();
            }
          });
    });
  }
}
