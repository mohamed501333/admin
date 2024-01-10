import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PDfpreview extends StatelessWidget {
  const PDfpreview({super.key, required this.v});
  final FutureOr<Uint8List> v;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(build: (d) => v),
    );
  }
}
