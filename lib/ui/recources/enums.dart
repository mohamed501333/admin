// ignore_for_file: camel_case_types, constant_identifier_names

import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/strings_manager.dart';

enum BlockAction {
  create_block,
  consume_block,
  unconsume_block,
  recive_block_form_cuttingUnit,
  cut_block_on_H,
  archive_block,
}

extension fdg on BlockAction {
  ActionModel get add {
    switch (this) {
      case BlockAction.create_block:
        return ActionModel(
            action: "create_block",
            who: SringsManager.myemail,
            when: DateTime.now());
      case BlockAction.consume_block:
        return ActionModel(
            action: "consume_block",
            who: SringsManager.myemail,
            when: DateTime.now());
      case BlockAction.unconsume_block:
        return ActionModel(
            action: "unconsume_block",
            who: SringsManager.myemail,
            when: DateTime.now());
      case BlockAction.recive_block_form_cuttingUnit:
        return ActionModel(
            action: "recive_block_form_cuttingUnit",
            who: SringsManager.myemail,
            when: DateTime.now());
      case BlockAction.cut_block_on_H:
        return ActionModel(
            action: "cut_block_on_H",
            who: SringsManager.myemail,
            when: DateTime.now());
      case BlockAction.archive_block:
        return ActionModel(
            action: "archive_block",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getactionTitle {
    switch (this) {
      case BlockAction.create_block:
        return "create_block";
      case BlockAction.consume_block:
        return "consume_block";
      case BlockAction.unconsume_block:
        return "unconsume_block";
      case BlockAction.recive_block_form_cuttingUnit:
        return "recive_block_form_cuttingUnit";
      case BlockAction.cut_block_on_H:
        return "cut_block_on_H";
      case BlockAction.archive_block:
        return "archive_block";
    }
  }
}

enum finalProdcutAction {
  incert_finalProduct_from_cutingUnit,
  final_prodcut_DidQalityCheck,
  out_order,
  archive_final_prodcut,
  recive_Done_Form_FinalProdcutStock,
  incert_finalProduct_from_Others,
  createInvoice,
}

extension fsfs on finalProdcutAction {
  ActionModel get add {
    switch (this) {
      case finalProdcutAction.incert_finalProduct_from_cutingUnit:
        return ActionModel(
            action: "incert_finalProduct_from_cutingUnit",
            who: SringsManager.myemail,
            when: DateTime.now());
      case finalProdcutAction.out_order:
        return ActionModel(
            action: "out_order",
            who: SringsManager.myemail,
            when: DateTime.now());
      case finalProdcutAction.archive_final_prodcut:
        return ActionModel(
            action: "archive_final_prodcut",
            who: SringsManager.myemail,
            when: DateTime.now());
      case finalProdcutAction.recive_Done_Form_FinalProdcutStock:
        return ActionModel(
            action: "recive_Done_Form_FinalProdcutStock",
            who: SringsManager.myemail,
            when: DateTime.now());
      case finalProdcutAction.final_prodcut_DidQalityCheck:
        return ActionModel(
            action: "final_prodcut_DidQalityCheck",
            who: SringsManager.myemail,
            when: DateTime.now());
      case finalProdcutAction.incert_finalProduct_from_Others:
        return ActionModel(
            action: "incert_finalProduct_from_Others",
            who: SringsManager.myemail,
            when: DateTime.now());
      case finalProdcutAction.createInvoice:
        return ActionModel(
            action: "createInvoice",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getactionTitle {
    switch (this) {
      case finalProdcutAction.incert_finalProduct_from_cutingUnit:
        return "incert_finalProduct_from_cutingUnit";
      case finalProdcutAction.out_order:
        return "out_order";
      case finalProdcutAction.archive_final_prodcut:
        return "archive_final_prodcut";
      case finalProdcutAction.recive_Done_Form_FinalProdcutStock:
        return "recive_Done_Form_FinalProdcutStock";
      case finalProdcutAction.final_prodcut_DidQalityCheck:
        return "final_prodcut_DidQalityCheck";
      case finalProdcutAction.incert_finalProduct_from_Others:
        return "incert_finalProduct_from_Others";
      case finalProdcutAction.createInvoice:
        return "createInvoice";
    }
  }
}

enum FractionActon {
  creat_fraction,
  archive_fraction,
  cut_fraction_OnHscissor,
  cut_fraction_OnRscissor
}

extension X5 on FractionActon {
  ActionModel get add {
    switch (this) {
      case FractionActon.creat_fraction:
        return ActionModel(
            action: "creat_fraction",
            who: SringsManager.myemail,
            when: DateTime.now());
      case FractionActon.archive_fraction:
        return ActionModel(
            action: "archive_fraction",
            who: SringsManager.myemail,
            when: DateTime.now());
      case FractionActon.cut_fraction_OnHscissor:
        return ActionModel(
            action: "cut_fraction_OnHscissor",
            who: SringsManager.myemail,
            when: DateTime.now());
      case FractionActon.cut_fraction_OnRscissor:
        return ActionModel(
            action: "cut_fraction_OnRscissor",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case FractionActon.creat_fraction:
        return "creat_fraction";
      case FractionActon.archive_fraction:
        return "archive_fraction";
      case FractionActon.cut_fraction_OnHscissor:
        return "cut_fraction_OnHscissor";
      case FractionActon.cut_fraction_OnRscissor:
        return "cut_fraction_OnRscissor";
    }
  }
}

enum InvoiceAction {
  creat_invoice,
  archive_invoice,
}

extension Xdf5 on InvoiceAction {
  ActionModel get add {
    switch (this) {
      case InvoiceAction.creat_invoice:
        return ActionModel(
            action: "creat_invoice",
            who: SringsManager.myemail,
            when: DateTime.now());
      case InvoiceAction.archive_invoice:
        return ActionModel(
            action: "archive_invoice",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case InvoiceAction.creat_invoice:
        return "creat_invoice";
      case InvoiceAction.archive_invoice:
        return "archive_invoice";
    }
  }
}

enum NonFinalType {
  floors,
  aspects,
  secondDegree,
  ExcellentsecondDegree,
  Halek;
}

extension Dkk on NonFinalType {
  String get getactionTitle {
    switch (this) {
      case NonFinalType.floors:
        return "floors";
      case NonFinalType.aspects:
        return "aspects";
      case NonFinalType.secondDegree:
        return "secondDegree";
      case NonFinalType.ExcellentsecondDegree:
        return "ExcellentsecondDegree";
      case NonFinalType.Halek:
        return "Halek";
    }
  }
}

enum NotFinalAction {
  create_Not_final_cumingFrom_H,
  create_Not_final_cumingFrom_R,
}

extension SSS on NotFinalAction {
  ActionModel get add {
    switch (this) {
      case NotFinalAction.create_Not_final_cumingFrom_H:
        return ActionModel(
            action: "create_Not_final_cumingFrom_H",
            who: SringsManager.myemail,
            when: DateTime.now());
      case NotFinalAction.create_Not_final_cumingFrom_R:
        return ActionModel(
            action: "create_Not_final_cumingFrom_R",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case NotFinalAction.create_Not_final_cumingFrom_H:
        return "create_Not_final_cumingFrom_H";
      case NotFinalAction.create_Not_final_cumingFrom_R:
        return "create_Not_final_cumingFrom_R";
    }
  }
}

enum customerAction {
  create_new_customer,
  archive_customer,
}

extension dfdf on customerAction {
  ActionModel get add {
    switch (this) {
      case customerAction.create_new_customer:
        return ActionModel(
            action: "create_new_customer",
            who: SringsManager.myemail,
            when: DateTime.now());
      case customerAction.archive_customer:
        return ActionModel(
            action: "archive_customer",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case customerAction.create_new_customer:
        return "create_new_customer";
      case customerAction.archive_customer:
        return "archive_customer";
    }
  }
}

enum OrderAction {
  create_order,
  Archive_order,
  order_aproved_from_calculation,
  order_aproved_from_control,
  order_colosed,
}

extension FF on OrderAction {
  ActionModel get add {
    switch (this) {
      case OrderAction.create_order:
        return ActionModel(
            action: "create_order",
            who: SringsManager.myemail,
            when: DateTime.now());
      case OrderAction.Archive_order:
        return ActionModel(
            action: "Archive_order",
            who: SringsManager.myemail,
            when: DateTime.now());
      case OrderAction.order_aproved_from_calculation:
        return ActionModel(
            action: "order_aproved_from_calculation",
            who: SringsManager.myemail,
            when: DateTime.now());
      case OrderAction.order_aproved_from_control:
        return ActionModel(
            action: "order_aproved_from_control",
            who: SringsManager.myemail,
            when: DateTime.now());
      case OrderAction.order_colosed:
        return ActionModel(
            action: "order_colosed",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case OrderAction.create_order:
        return "create_order";
      case OrderAction.Archive_order:
        return "Archive_order";
      case OrderAction.order_aproved_from_calculation:
        return "order_aproved_from_calculation";
      case OrderAction.order_aproved_from_control:
        return "order_aproved_from_control";
      case OrderAction.order_colosed:
        return "order_colosed";
    }
  }
}
