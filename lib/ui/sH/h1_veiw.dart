// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types
import 'package:flutter/material.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/sH/Widgets.dart';
import 'package:provider/provider.dart';

import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/validation.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/sH/H1_veiwModel.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:jason_company/ui/recources/color_manager.dart';
import 'package:jason_company/ui/chips/constans_view.dart';

// ignore: must_be_immutable
class H1Veiw extends StatefulWidget {
  const H1Veiw({super.key, required this.scissor});

  final int scissor;
  @override
  State<H1Veiw> createState() => _H1VeiwState();
}

class _H1VeiwState extends State<H1Veiw> {
  H1VeiwModel vm = H1VeiwModel();
  @override
  void dispose() {
    vm.permanentFractons.clear;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, b, child) {
        List<BlockModel> blocks = b.blocks
            .where((element) =>
                element.actions.if_action_exist(
                    BlockAction.consume_block.getactionTitle) ==
                true)
            .toList();
        return Form(
          key: vm.formKey,
          child: Column(
            children: [
              fields(vm: vm, b: blocks),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Results(vm: vm),
                  Chips(
                    vm: vm,
                    b: blocks,
                    scissor: widget.scissor,
                  ),
                  buttoms(
                    vm: vm,
                    b: blocks,
                    scissor: widget.scissor,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class Results extends StatelessWidget {
  const Results({
    super.key,
    required this.vm,
  });

  final H1VeiwModel vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Consumer<ObjectBoxController>(
        builder: (context, fractions, child) {
          return Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: vm.permanentFractons
                      .map(
                        (e) => Container(
                            margin:
                                const EdgeInsets.only(bottom: 12, right: 12),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: ColorManager.gray,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: ColorManager.blueGrey, width: 3)),
                            child: Text(
                              "${e.hight}*${e.wedth}*${e.lenth}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                      )
                      .toList(),
                ),
              ))
            ],
          );
        },
      ),
    );
  }
}

class Chips extends StatelessWidget {
  const Chips({
    super.key,
    required this.vm,
    required this.b,
    required this.scissor,
  });
  final H1VeiwModel vm;
  final List<BlockModel> b;
  final int scissor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .5,
      width: 150,
      child: Column(
        children: [
          Selector<ObjectBoxController, List<ChipFraction>>(
            selector: (_, myType) => ObjectBoxController().fractionchips,
            builder: (context, chips, child) {
              return Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    spacing: 9,
                    children: chips
                        .map((e) => InkWell(
                              onLongPress: () {
                                context
                                    .read<ObjectBoxController>()
                                    .deleteFractionchip(e.id);
                              },
                              onTap: () {
                                if (vm.validate()) {
                                  vm.addpermanentFractons(
                                      context, b, scissor, e);
                                  context.read<ObjectBoxController>().get();
                                  vm.clearfields();
                                }
                              },
                              child: Chip(
                                  labelStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  label: Text(
                                      "  ${e.hight.removeTrailingZeros.toString()}* ${e.width.removeTrailingZeros.toString()}* ${e.lenth.removeTrailingZeros.toString()}")),
                            ))
                        .toList(),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class buttoms extends StatelessWidget {
  const buttoms({
    super.key,
    required this.b,
    required this.vm,
    required this.scissor,
  });
  final List<BlockModel> b;
  final int scissor;
  final H1VeiwModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              if (vm.validate()) {
                BlockModel m = b
                    .where((e) =>
                        e.number ==
                            vm
                                .get_block_of_num_in_controller(b, context)
                                .number &&
                        e.serial ==
                            vm
                                .get_block_of_num_in_controller(b, context)
                                .serial)
                    .toList()[0];
                double vloumeOfFractions;
                double vloumeOfblock;

                if (vm.permanentFractons.isNotEmpty) {
                  vloumeOfblock = m.width * m.lenth * m.hight / 1000000;
                  vloumeOfFractions = vm.permanentFractons
                      .map((e) => e.wedth * e.hight * e.lenth / 1000000)
                      .reduce((a, b) => a + b);
                  if (vloumeOfblock < vloumeOfFractions) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('حجم النواتج اكبر من حجم البلوك')));
                    vm.permanentFractons.clear();
                  } else {
                    if (vm.permanentFractons.isNotEmpty) {
                      vm.add_fraction(context, b, scissor);
                    }
                  }
                }
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                " قص",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )),
        ChipsForH123(),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              context.gonext(
                  context,
                  ReportwForHView(
                    scissor: scissor,
                  ));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                " تقرير ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )),
      ],
    );
  }
}

class fields extends StatelessWidget {
  const fields({
    super.key,
    required this.b,
    required this.vm,
  });
  final List<BlockModel> b;
  final H1VeiwModel vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const DropDdowen002(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 18),
            child: CustomTextFormField(
                hint: " وزن دون التام",
                width: 120,
                validator: Validation.validateothers,
                controller: vm.wightcontroller),
          ),
          Column(
            children: [
              DropDdowen(b: b),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                child: CustomTextFormField(
                    autovalidate: true,
                    hint: "رقم البلوك ",
                    width: 90,
                    validator: vm.validate_if_Exist(b, context),
                    controller: vm.numbercontroller),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DropDdowen extends StatelessWidget {
  const DropDdowen({super.key, required this.b});
  final List<BlockModel> b;

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, v, child) {
        b.isEmpty
            ? context.read<ObjectBoxController>().serial = null
            : DoNothingAction();
        return DropdownButton(
            value: context.read<ObjectBoxController>().serial,
            items: b
                .filterserials()
                .map((e) => e.serial)
                .toList()
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                context.read<ObjectBoxController>().serial = v;
                context.read<ObjectBoxController>().get();
              }
            });
      },
    );
  }
}

class DropDdowen002 extends StatelessWidget {
  const DropDdowen002({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, v, child) {
        return DropdownButton(
            value: context.read<ObjectBoxController>().initial,
            items: v.notfials
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                context.read<ObjectBoxController>().initial = v;
                context.read<ObjectBoxController>().get();
              }
            });
      },
    );
  }
}
