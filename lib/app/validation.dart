// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/Customer_controller.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/blocksStock/outofStock_viewmoder.dart';
import 'package:jason_company/ui/customers/customers_viewModel.dart';
import 'package:jason_company/ui/final_product_outOrder/outOfStockOrder_veiwModel.dart';
import 'package:jason_company/ui/block_out_of_stock/outOfStock_viewModel.dart';
import 'package:jason_company/ui/final_product_stock/Stock_of_finalProduct_ViewModel.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class Validation {
  static validate_if_block_exist(
      BuildContext context, BlocksStockViewModel vm) {
    return (String? value) {
      if (value!.isEmpty) {
        return "فارغ";
      }
      List<BlockModel> blocks = context.read<BlockFirebasecontroller>().blocks;
      String blockNum = vm.blocknumbercontroller.text;
      String blockSerial = vm.codecontroller.text;
      var condition = blocks.where(
          (e) => e.number == blockNum.to_int() && e.serial == blockSerial);
      if (condition.isNotEmpty) {
        return "موجود";
      }

      return null;
    };
  }

  static if_cusomer_serial_already_exist(
      BuildContext context, Customer_viewmodel vm) {
    return (String? value) {
      if (value!.isEmpty) {
        return "فارغ";
      }
      List<CustomerModel> customers =
          context.read<Customer_controller>().customers;
      String customerSerial = vm.customerSerial.text;
      var condition =
          customers.where((e) => e.serial == customerSerial.to_int());
      if (condition.isNotEmpty) {
        return "موجود";
      }

      return null;
    };
  }

  static validatefromTo(BuildContext context, BlocksStockViewModel vm) {
    return (String? value) {
      if (value!.isEmpty) {
        return "فارغ";
      }
      if (vm.to.text.to_int() < vm.from.text.to_int()) {
        return "حطأ";
      }

      var list1 = vm.to.text.to_int() < vm.from.text.to_int()
          ? []
          : List<int>.generate(vm.to.text.to_int() - vm.from.text.to_int() + 1,
              (i) => vm.from.text.to_int() + i);
      var list2 = context
          .read<BlockFirebasecontroller>()
          .blocks
          .where((element) => element.serial == vm.codecontroller.text)
          .map((e) => e.number)
          .toList();
      list2.removeWhere((item) => !list1.contains(item));
      if (list2.isNotEmpty) {
        return "موجود";
      }

      return null;
    };
  }

  static if_cusomer_serial_exist(BuildContext context) {
    return (String? value) {
      if (value!.isEmpty) {
        return "فارغ";
      }

      if (value.isEmpty) {
        return 'لا تترك هذا الحقل فارغ';
      } else {
        try {
          double.parse(value);
        } catch (e) {
          return "ادخل قيمه صحيحه";
        }
      }
      List<CustomerModel> customers =
          context.read<Customer_controller>().customers;
      var condition = customers.where((e) => e.serial == value.to_int());
      if (condition.isEmpty) {
        return "غير موجود";
      }

      return null;
    };
  }

  static validate_if_block_in_Stock_or_already_consumed(
      BuildContext context, OutOfStockViewModel vm) {
    return (String? value) {
      if (value!.isEmpty) {
        return "فارغ";
      }
      List<BlockModel> blocks = context.read<BlockFirebasecontroller>().blocks;
      String blockNum = vm.blocknumbercontroller.text;
      String? blockSerial = context.read<ObjectBoxController>().serial;
      var condition = blocks.where(
          (e) => e.number == blockNum.to_int() && e.serial == blockSerial);
      if (condition.isEmpty) {
        return "غير موجود";
      }
      var condition11 = blocks.where((e) =>
          e.number == blockNum.to_int() &&
          e.serial == blockSerial &&
          e.actions.block_action_Stutus(BlockAction.consume_block) == true);
      if (condition11.isNotEmpty) {
        return " مصروف";
      }

      return null;
    };
  }

  static String? validateothers(String? value) {
    if (value!.isEmpty) {
      return "فارغ";
    }

    return null;
  }

  static String? validateOOOOOO(String? value) {
    if (value!.isEmpty) {
      return "فارغ";
    }
    if (value == "") {
      return "فارغ";
    }
    if (value == 0.0) {
      return "فارغ";
    }
    if (value == 0) {
      return "فارغ";
    }
    if (value == "0") {
      return "فارغ";
    }
    if (value == "0.0") {
      return "فارغ";
    }

    return null;
  }

  static amou(ItemModel itemData, outOfStockOrderveiwModel vm) {
    return (String? value) {
      var condition = itemData.total > 0;
      if (!condition) {
        return "لا يمكن";
      }
      return null;
    };
  }

  static String? validateothe(String? value) {
    if (value!.isEmpty) {
      return "فارغ";
    }

    if (value.isEmpty) {
      return 'لا تترك هذا الحقل فارغ';
    } else {
      try {
        double.parse(value);
      } catch (e) {
        return "ادخل قيمه صحيحه";
      }
    }
    return null;
  }
  static String? validateIFimpty(String? value) {
    if (value!.isEmpty) {
      return "فارغ";
    }

    if (value.isEmpty) {
      return 'لا تترك هذا الحقل فارغ';
    } 
    return null;
  }
}
