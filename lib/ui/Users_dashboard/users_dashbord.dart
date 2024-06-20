// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, must_be_immutable

import 'package:flutter/material.dart';
import 'package:jason_company/controllers/users_controllers.dart';
import 'package:jason_company/ui/recources/userpermitions.dart';
// import 'package:jason_company/models/moderls.dart';
// import 'package:jason_company/ui/recources/userpermitions.dart';

import 'package:provider/provider.dart';

class UsersDashboard extends StatelessWidget {
  UsersDashboard({super.key});
  TextEditingController useremail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.read<Users_controller>().getAllUsers();
    return Consumer<Users_controller>(
      builder: (context, myType, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                              height: 200,
                              child: Column(children: [
                                TextField(
                                  controller: useremail,
                                )
                              ]),
                            ),
                            actions: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No')),
                              ElevatedButton(
                                  // style: ElevatedButton.styleFrom(
                                  //     primary: Colors.red),
                                  onPressed: () {
                                    // myType.Add_new_user(useremail.text);

                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'yes',
                                  )),
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.add))
            ],
            title: const DropDdowenForUsers(),
          ),
          body: ListView(
              children: myType.users
                  .map(
                    (u) => ExpansionTile(
                        title: Text(
                          " (${u.name}) ",
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        children: UserPermition.values
                            .map((g) => Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.greenAccent),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: CheckboxListTile(
                                      activeColor: Colors.blue,
                                      checkColor: Colors.white,
                                      autofocus: false,
                                      onChanged: (v) {
                                        if (u.permitions.contains(g.getTitle)) {
                                          u.permitions.removeWhere(
                                              (a) => a == g.getTitle);
                                          myType.updateUser(u);
                                        } else {
                                          u.permitions.add(g.getTitle);
                                          myType.updateUser(u);
                                        }
                                      },
                                      title: Text(
                                        g.getTitle,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      value: u.permitions.contains(g.getTitle)),
                                ))
                            .toList()),
                  )
                  .toList()),
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
            // DropdownButton(
            //     value: Mytype.initialforradioqq,
            //     items: Mytype.users
            //         .map((e) => e.uidemail)
            //         .toList()
            //         .map((e) => DropdownMenuItem(
            //               value: e,
            //               child: Text(e.toString()),
            //             ))
            //         .toList()
            //         .reversed
            //         .toList(),
            //     onChanged: (v) {
            //       if (v != null) {
            //         Mytype.initialforradioqq = v;

            //         Mytype.Refrsh_ui();
            //       }
            //     }),
          ],
        );
      },
    );
  }
}
