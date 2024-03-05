import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/services/pdfprevei.dart';
import 'package:jason_company/ui/purching/componants.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class singnuturePad extends StatelessWidget {
   singnuturePad({
    super.key,
  });

  final keysingaturepad = GlobalKey<SfSignaturePadState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(width: 3), color: Colors.white),
          child: SfSignaturePad(
            strokeColor: Colors.black,
            minimumStrokeWidth: 10,
            key: keysingaturepad,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              keysingaturepad.currentState!.clear();
            },
            child: const Text("clear")),
        ElevatedButton(
            onPressed: () async {
              keysingaturepad.currentState
                  ?.toImage()
                  .then((value) =>
                      value.toByteData(format: ImageByteFormat.png))
                  .then((value) => value!.buffer.asUint8List())
                  .then((value) => generate(value))
                  .then((value) => context.gonext(
                      context,
                      PDfpreview(
                        v: value.save(),
                      )));
            },
            child: const Text("Done"))
      ],
    );
  }
}
