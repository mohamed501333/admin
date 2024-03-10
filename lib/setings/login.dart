import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/main.dart';
import 'package:jason_company/ui/main/main_view.dart';

class MyloginPage extends StatefulWidget {
  const MyloginPage({super.key});
  @override
  State<MyloginPage> createState() => _MyStatefulWidgetState();
}
class _MyStatefulWidgetState extends State<MyloginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
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
                      FirebaseAuth.instance.currentUser?.email.toString() ?? "",
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
                        formKey.currentState?.validate();
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: nameController.text.toString(),
                                password: passwordController.text.toString())
                            .then((value) {
                          setState(() {});
                          context.gonextAnsRemove(context, Mainview());
                        });
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
                        FirebaseAuth.instance.signOut().then((value) {
                          setState(() {});
                          context.gonextAnsRemove(context, const MyApp());
                        });
                      },
                    )),
              ],
            ),
          )),
    );
  }
}
