// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:jason_company/ui/recources/color_manager.dart';

// ignore: must_be_immutable
class Item extends StatelessWidget {
  Item(
    this.width,
    this.color,
    this.titele,
    this.icon, {
    this.ontap,
    super.key,
  });
  void Function()? ontap;
  double width;
  final Color color;
  final String titele;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(top: 6),
        width: width,
        height: 100,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                icon,
                color: ColorManager.white,
                size: 36,
              ),
              Text(
                titele,
                style: TextStyle(
                    color: ColorManager.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
