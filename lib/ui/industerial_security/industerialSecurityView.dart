import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jason_company/controllers/industerialSecurityController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/commen/errmsg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class InsusterialSecurityView extends StatelessWidget {
  InsusterialSecurityView({super.key});
  MobileScannerController controller = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Consumer<IndusterialSecuritycontroller>(
      builder: (context, myType, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              errmsg(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 270,
                child: MobileScanner(
                  controller: controller,
                  onDetect: (a) async {
                    postrecord(myType, a);
                    controller.stop();
                  },
                ),
              ),
              buttoms(controller: controller),
              Header(),
              SingleChildScrollView(
                child: Column(
                  children: myType.all
                      .map((e) =>
                          DataRow(record: e, index: myType.all.indexOf(e)))
                      .toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void postrecord(IndusterialSecuritycontroller myType, BarcodeCapture a) {
    print(a.barcodes.first.rawValue);
    myType.getImageFromCamera(90, 101).then((e) {
      var record = IndusterialSecurityModel(
          ID: DateTime.now().millisecondsSinceEpoch,
          date: DateTime.now(),
          place: a.barcodes.first.rawValue!,
          ImageId: DateTime.now().millisecondsSinceEpoch,
          image: e,
          note: 'لا يوجد');
      myType.postRecord(record);
    });
  }
}

class buttoms extends StatelessWidget {
  const buttoms({
    super.key,
    required this.controller,
  });

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () {
              controller.toggleTorch();
            },
            icon: const Icon(Icons.flashlight_off)),
        ElevatedButton(
            onPressed: () {
              controller.start();
            },
            child: const Text('ابدء')),
        ElevatedButton(
            onPressed: () {
              controller.stop();
            },
            child: const Text('اغلق')),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});
  final color = const Color.fromARGB(255, 111, 191, 216);
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(),
            color: color,
            borderRadius: BorderRadius.circular(11)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cell('النقطه', 70),
            cell('', 70),
            cell('ملاحظات', 70),
          ].reversed.toList(),
        ),
      ),
    );
  }

  SizedBox cell(String tittle, double width) => SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Center(
            child: Text(
              tittle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
}

class DataRow extends StatelessWidget {
  DataRow({
    Key? key,
    required this.record,
    required this.index,
  }) : super(key: key);
  final IndusterialSecurityModel record;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(),
            color: index % 2 == 0
                ? const Color.fromARGB(255, 205, 226, 241)
                : const Color.fromARGB(255, 243, 220, 143)),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              cell(
                record.place.toString(),
                70,
              ),
            ].reversed.toList(),
          ),
        ),
      ),
    );
  }

  SizedBox cell(String tittle, double width) => SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Center(
            child: Text(
              tittle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
}
