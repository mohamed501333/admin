// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:jason_company/controllers/users_controllers.dart';
import 'package:jason_company/ui/recources/enums.dart';

import 'package:provider/provider.dart';

class UsersDashboard extends StatelessWidget {
  const UsersDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Users_controller>(
      builder: (context, myType, child) {
        // User currentUser = FirebaseAuth.instance.currentUser!;
        // myType.Add_User_permition(
        //     Users(
        //         id: DateTime.now().millisecondsSinceEpoch,
        //         uidemail: currentUser.email ?? "",
        //         uid: currentUser.uid,
        //         name: "",
        //         permitions: []),
        //     UserPermition.show_block_incetion);
        return Scaffold(
          appBar: AppBar(
            title: const DropDdowenForUsers(),
          ),
          body: Column(
            children: [
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (myType.initialforracc != null) {
                          myType.Add_User_permition(myType.initialforracc!);
                        }
                      },
                      child: const Text("اضافه")),
                  const DropDdowenForUsersactions()
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: myType.users
                          .where((element) =>
                              element.uidemail == myType.initialforradioqq)
                          .isNotEmpty
                      ? myType.users
                          .where((element) =>
                              element.uidemail == myType.initialforradioqq)
                          .first
                          .permitions
                          .map((e) => GestureDetector(
                              onDoubleTap: () {
                                myType.remove_User_permition(e.tittle);
                              },
                              child: Container(
                                height: 40,
                                color: Colors.grey,
                                margin: const EdgeInsets.only(top: 20),
                                child: Text(
                                  e.tittle,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              )))
                          .toList()
                      : [],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class DropDdowenForUsers extends StatelessWidget {
  const DropDdowenForUsers({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<Users_controller>(
      builder: (context, Mytype, child) {
        return Column(
          children: [
            DropdownButton(
                value: Mytype.initialforradioqq,
                items: Mytype.users
                    .map((e) => e.uidemail)
                    .toList()
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList()
                    .reversed
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    Mytype.initialforradioqq = v;

                    Mytype.Refrsh_ui();
                  }
                }),
          ],
        );
      },
    );
  }
}

class DropDdowenForUsersactions extends StatelessWidget {
  const DropDdowenForUsersactions({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<Users_controller>(
      builder: (context, Mytype, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
                value: Mytype.initialforracc,
                items: UserPermition.values
                    .map((e) => e)
                    .toList()
                    .toList()
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    Mytype.initialforracc = v;

                    Mytype.Refrsh_ui();
                  }
                }),
          ],
        );
      },
    );
  }
}
