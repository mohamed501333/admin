import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jason_company/controllers/main_controller.dart';
import 'package:jason_company/controllers/users_controllers.dart';
import 'package:jason_company/data/sharedprefs.dart';
import 'package:jason_company/ui/commen/errmsg.dart';
import 'package:jason_company/ui/recources/publicVariables.dart';
import 'package:provider/provider.dart';

class MyloginPage extends StatelessWidget {
  MyloginPage({super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Consumer2<Users_controller, MainController>(
              builder: (context, myType, mm, child) {
                TextEditingController nameController = TextEditingController();
                TextEditingController passwordController =
                    TextEditingController();

                nameController.text = Sharedprfs.getemail() ?? '';
                passwordController.text = Sharedprfs.getpassword() ?? '';
                print(nameController.text);
                if (myType.currentuser == null &&
                    nameController.text != '' &&
                    passwordController.text != '' &&
                    ip != '') {
                  print(nameController.text);
                  myType.getData(nameController.text, passwordController.text);
                }

                return ListView(
                  children: <Widget>[
                    errmsg(),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          ' تسجيل الدخول  ك',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          Sharedprfs.getemail() ?? "",
                          style: const TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "فارغ";
                          }
                          return null;
                        },
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "فارغ";
                          }
                          return null;
                        },
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Login'),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<Users_controller>().getData(
                                  nameController.text.toString(),
                                  passwordController.text.toString());
                            }
                          },
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Login Out'),
                          onPressed: () {
                            myType.currentuser = null;
                            Sharedprfs.removeemailAndPassword();
                            passwordController.text = '';
                            nameController.text = '';
                            initialized = false;
                            myType.Refrsh_ui();
                          },
                        )),
                    const Gap(15),
                    Consumer<Users_controller>(
                      builder: (context, myType, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'اختر طريقة االاتصال',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: true,
                                        groupValue: internet,
                                        onChanged: (onChanged) {
                                          myType
                                              .changeValOf_internet(onChanged!);
                                        }),
                                    const Text('الانترنت')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: false,
                                        groupValue: internet,
                                        onChanged: (onChanged) {
                                          myType
                                              .changeValOf_internet(onChanged!);
                                        }),
                                    const Text("السيرفر")
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    )
                  ],
                );
              },
            ),
          )),
    );
  }
}
