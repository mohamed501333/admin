import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {required this.hint,
      this.validator,
      super.key,
      this.onChanged,
      this.autovalidate = false,
      this.keybordtupe = TextInputType.number,
      required this.width,
      required this.controller,
      this.ontap});
  final TextInputType keybordtupe;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String? Function()? ontap;
  final double width;
  bool autovalidate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width,
          child: TextFormField(
              onTap: ontap,
              onChanged: onChanged,
              inputFormatters: [FilteringTextInputFormatter.deny(' ')],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              controller: controller,
              keyboardType: keybordtupe,
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.teal)),
                  border: const OutlineInputBorder(),
                  hintText: hint,
                  labelText: hint,
                  labelStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  fillColor: const Color.fromARGB(31, 184, 161, 161),
                  filled: true)),
        ),
      ],
    );
  }
}
