// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/validation.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                const SizedBox(height: 60.0),
                const Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Create New User",
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                )
              ],
            ),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: username,
                    decoration: InputDecoration(
                        hintText: "name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.person)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: email,
                    validator: Validation.validateIFimpty,
                    decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.email)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: password,
                    validator: Validation.validateIFimpty,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.book),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      try {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        )
                            .then((value) {
                          value.user!.updateDisplayName(username.text);
                          email.clear();
                          password.clear();
                          username.clear();
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.purple,
                  ),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
