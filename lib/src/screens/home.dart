import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pixbit/src/settings/settings_controller.dart';
import 'package:pixbit/src/utils/constants.dart';
import 'package:pixbit/src/utils/router.dart';
import 'package:provider/provider.dart';

import '../models/users.dart';
import '../network/api.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _editingController = new TextEditingController();
  bool isloading = true;
  Users? user;
  String searchQuery = '';
  String? temp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    try {
      log(context.read<SettingsController>().token.toString());
      user = await Api(token: context.read<SettingsController>().token).users();
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  List<UsersDataData?> getStudentList() {
    user!.data!.data!.sort((a, b) =>
        a!.firstName!.toLowerCase().compareTo(b!.firstName!.toLowerCase()));
    var users = user!.data!.data!
        .where((s) =>
            s!.firstName!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.pushNamed(context, RouterHelper.addStudentRoute);
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('All Contacts'),
        ),
        body: isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(
                            Icons.search,
                            size: 12.0,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 13.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onChanged: (String e) {
                          setState(() {
                            searchQuery = e;
                          });
                        },
                        controller: _editingController,
                      ))
                    ],
                  ),
                  Expanded(
                      child: ListView.separated(
                    itemBuilder: (c, i) {
                      if (i == 0) return SizedBox.shrink();
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouterHelper.detailsRoute,
                              arguments: user!.data!.data![i]);
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "$SERVER_ADDRESS${getStudentList()[i]?.profilePicture}"),
                        ),
                        title: Text(getStudentList()[i]?.firstName ?? 'null'),
                      );
                    },
                    separatorBuilder: (c, i) {
                      if (i == getStudentList().length) {
                        return SizedBox.shrink();
                      } else if (temp !=
                          getStudentList()[i + 1]!
                              .firstName!
                              .characters
                              .first
                              .toLowerCase()) {
                        temp = getStudentList()[i + 1]!
                            .firstName!
                            .characters
                            .first
                            .toLowerCase();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getStudentList()[i + 1]!
                                .firstName!
                                .characters
                                .first
                                .toLowerCase()),
                            Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                          ],
                        );
                      } else
                        return Divider();
                    },
                    itemCount: getStudentList().length,
                  ))
                ],
              ));
  }
}
