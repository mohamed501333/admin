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

enum CategoryAction {
  creat_new_block_category,
  archive_block_category,
}

extension ddsd on CategoryAction {
  ActionModel get add {
    switch (this) {
      case CategoryAction.creat_new_block_category:
        return ActionModel(
            action: "creat_new_block_category",
            who: SringsManager.myemail,
            when: DateTime.now());
      case CategoryAction.archive_block_category:
        return ActionModel(
            action: "archive_block_category",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case CategoryAction.creat_new_block_category:
        return "creat_new_block_category";
      case CategoryAction.archive_block_category:
        return "archive_block_category";
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

enum UserPermition {
  show_all,
  show_block_incetion,
  show_blockconsume,
  show_cutting_orders,
  show_finalProdcut_stock,
  show_finalprodcut_importedFormcuttingUint,
  show_finalprodcut_invoice,
  show_finalprodcut_invoicemaking,
  show_customers,
  show_massaging,
  show_scissors,
  show_not_final_stock,

  show_Reports_finalprodcut,
  show_Reports_final_prodcutscisors,
  show_Reports_totals_of_blocks,
  show_Reports_consume_boock,
  show_Reports_details_of_block_stock,
  show_Reports_details_of_sizes_of_block_stock,
  show_Reports_details_of_finalProdcut_stock,
  show_Reports_every_serial,
  show_Reports_H,
  show_Reports_R,

  show_date_in_block_out_of_stock,
  show_date_in_block_stock,
  show_date_in_finalProduct_imported,
  show_date_in_invoices,
  fields_buttoms_consumeBlock,
  show_search_in_customers,
  show_cusotmer_name_in_cutting_order,
  show_setting_in_out_order,

  incert_in_finalProdcut_imorted,
  incert_unregular_in_importedfinal_prodcut,
  incert_in_block_stock,
  incert_in_final_prodcutStock,
  incert_in_cutting_order,
  incert_in_customers,

  delete_in_cutting_order,
  delete_in_consume_block,
  delete_in_imported_finalprodcut,
  delete_in_finalprodcut_details,

  can_print_in_cutting_order,

  can_close_in_cutting_order,
  can_aprove_from_controll,
  can_aprove_from_calculation,
  can_aprove_from_quality,
  can_aprove_from_recive_from_final_prodcut,
  allow_edit_in_details_finalProdcut,
  allow_edit_in_details_blocks,

  show_users_actions,
  can_get_data_of_blocks,
  can_get_data_of_final_prodcut,
  can_get_data_of_invoice,
  can_get_data_of_customers,
  can_get_data_of_orders,
  can_get_data_of_fractions,
  can_get_data_of_notfinals,
  not_working,
}

extension QQ on UserPermition {
  UserpermitionTittle get add {
    switch (this) {
      case UserPermition.show_all:
        return UserpermitionTittle(tittle: "show_all");
      case UserPermition.show_block_incetion:
        return UserpermitionTittle(tittle: "اضافه الى البلوكات");
      case UserPermition.show_blockconsume:
        return UserpermitionTittle(tittle: "صرف بلوكات");
      case UserPermition.show_cutting_orders:
        return UserpermitionTittle(tittle: "اوامر التشغيل");
      case UserPermition.show_finalProdcut_stock:
        return UserpermitionTittle(tittle: "رصيد منتح تام");
      case UserPermition.show_finalprodcut_importedFormcuttingUint:
        return UserpermitionTittle(tittle: "وارد تام المقصات");
      case UserPermition.show_finalprodcut_invoice:
        return UserpermitionTittle(tittle: "اذون صرف منتج تام");
      case UserPermition.show_finalprodcut_invoicemaking:
        return UserpermitionTittle(tittle: "صرف منتج تام");
      case UserPermition.show_customers:
        return UserpermitionTittle(tittle: "العملاء");
      case UserPermition.show_massaging:
        return UserpermitionTittle(tittle: "المراسله والطلبات");
      case UserPermition.show_users_actions:
        return UserpermitionTittle(tittle: "show_users_actions");
      case UserPermition.show_scissors:
        return UserpermitionTittle(tittle: "المقصات");
      case UserPermition.show_Reports_finalprodcut:
        return UserpermitionTittle(tittle: "تقارير منتج تام");
      case UserPermition.show_Reports_final_prodcutscisors:
        return UserpermitionTittle(tittle: "تقارير منتج تام لكل مقص");
      case UserPermition.show_Reports_totals_of_blocks:
        return UserpermitionTittle(tittle: "تقارير اجماليات البلوكات");
      case UserPermition.show_Reports_consume_boock:
        return UserpermitionTittle(tittle: "تقارير صرف بلوكات");
      case UserPermition.show_Reports_details_of_block_stock:
        return UserpermitionTittle(tittle: "تفاصيل مخزن البلوكات");
      case UserPermition.show_Reports_details_of_finalProdcut_stock:
        return UserpermitionTittle(tittle: "تفاصيل مخزن منتج تام");
      case UserPermition.incert_in_finalProdcut_imorted:
        return UserpermitionTittle(
            tittle: "امكانيه الاضافه الى وارد تام المقصات");
      case UserPermition.incert_in_block_stock:
        return UserpermitionTittle(tittle: "امكانيه الاضافه الى مخزن البلوك");
      case UserPermition.fields_buttoms_consumeBlock:
        return UserpermitionTittle(tittle: "الزر والحقول فى صرف بلوكات");
      case UserPermition.incert_in_final_prodcutStock:
        return UserpermitionTittle(
            tittle: "امكانيه الاضافه الى مخزن المنتج التام");
      case UserPermition.incert_in_cutting_order:
        return UserpermitionTittle(tittle: "الاضافه الى اوامر التشغيل");
      case UserPermition.incert_in_customers:
        return UserpermitionTittle(tittle: "الاضافه الى العملاء");

      case UserPermition.delete_in_cutting_order:
        return UserpermitionTittle(tittle: "المسح او الاغلاق فى اوامر التشغيل");
      case UserPermition.delete_in_consume_block:
        return UserpermitionTittle(tittle: "المسح فى صرف بلوكات");
      case UserPermition.show_date_in_block_out_of_stock:
        return UserpermitionTittle(tittle: "التاريخ فى صرف البلوكات");
      case UserPermition.show_date_in_finalProduct_imported:
        return UserpermitionTittle(tittle: "التاريخ فى  وارد تام المقصات");
      case UserPermition.delete_in_imported_finalprodcut:
        return UserpermitionTittle(tittle: "امكانية المسح فى وارد تام المقصات");
      case UserPermition.show_date_in_block_stock:
        return UserpermitionTittle(tittle: "التاريخ فى رصيد البلوكات");
      case UserPermition.can_print_in_cutting_order:
        return UserpermitionTittle(tittle: "امكانية الطباعه فى اوامر التشغيل");
      case UserPermition.can_close_in_cutting_order:
        return UserpermitionTittle(tittle: "امكانية الاغلاق فى اوامر التشغيل");
      case UserPermition.can_aprove_from_controll:
        return UserpermitionTittle(tittle: "امكانية الموافقه من جهة الكنترل");
      case UserPermition.can_aprove_from_quality:
        return UserpermitionTittle(tittle: "امكانية الموافقه من جهة الجوده");
      case UserPermition.can_aprove_from_recive_from_final_prodcut:
        return UserpermitionTittle(tittle: "امكانية الاستلام من جهة مخزن تام");
      case UserPermition.can_aprove_from_calculation:
        return UserpermitionTittle(tittle: "امكانية الموافقه من جهة الحسابات");
      case UserPermition.incert_unregular_in_importedfinal_prodcut:
        return UserpermitionTittle(
            tittle: "اضافة مقاسات شاذه فى وارد تام المقصات");
      case UserPermition.show_not_final_stock:
        return UserpermitionTittle(tittle: "مخزن دون التام");
      case UserPermition.allow_edit_in_details_finalProdcut:
        return UserpermitionTittle(tittle: "التعديل فى تفاصيل منتج تام");
      case UserPermition.not_working:
        return UserpermitionTittle(tittle: "اخرى");
      case UserPermition.can_get_data_of_blocks:
        return UserpermitionTittle(tittle: "can_get_data_of_blocks");
      case UserPermition.can_get_data_of_final_prodcut:
        return UserpermitionTittle(tittle: "can_get_data_of_final_prodcut");
      case UserPermition.can_get_data_of_invoice:
        return UserpermitionTittle(tittle: "can_get_data_of_invoice");
      case UserPermition.can_get_data_of_customers:
        return UserpermitionTittle(tittle: "can_get_data_of_customers");
      case UserPermition.can_get_data_of_orders:
        return UserpermitionTittle(tittle: "can_get_data_of_orders");
      case UserPermition.can_get_data_of_fractions:
        return UserpermitionTittle(tittle: "can_get_data_of_fractions");
      case UserPermition.can_get_data_of_notfinals:
        return UserpermitionTittle(tittle: "can_get_data_of_notfinals");

      case UserPermition.delete_in_finalprodcut_details:
        return UserpermitionTittle(tittle: "المسح فى تفاصيل تام الصنع");
      case UserPermition.show_date_in_invoices:
        return UserpermitionTittle(tittle: " التاريخ فى ازون التحميل");
      case UserPermition.show_search_in_customers:
        return UserpermitionTittle(tittle: "عرض البحث فى العملاء");
      case UserPermition.show_cusotmer_name_in_cutting_order:
        return UserpermitionTittle(tittle: "عرض اسم العميل فى اوامر التشغيل");
      case UserPermition.allow_edit_in_details_blocks:
        return UserpermitionTittle(
            tittle: "امكانية التعديل فى تفاصيل البلوكات");
      case UserPermition.show_Reports_every_serial:
        return UserpermitionTittle(tittle: "عرض تقرير صبات البلوكات");
      case UserPermition.show_Reports_details_of_sizes_of_block_stock:
        return UserpermitionTittle(tittle: "عرض تقرير  تفاصيل مقاسات البلوكات");
      case UserPermition.show_Reports_H:
        return UserpermitionTittle(tittle: "عرض تقرير  المقصات الراسى");
      case UserPermition.show_Reports_R:
        return UserpermitionTittle(tittle: "عرض تقرير المقصات الدائرى");
      case UserPermition.show_setting_in_out_order:
        return UserpermitionTittle(tittle: "عرض الاعدادات فى صرف منتج تام");
    }
  }

  String get getTitle {
    switch (this) {
      case UserPermition.show_setting_in_out_order:
        return "عرض الاعدادات فى صرف منتج تام";
      case UserPermition.show_Reports_H:
        return "عرض تقرير  المقصات الراسى";
      case UserPermition.show_Reports_R:
        return "عرض تقرير المقصات الدائرى";
      case UserPermition.show_Reports_details_of_sizes_of_block_stock:
        return "عرض تقرير  تفاصيل مقاسات البلوكات";
      case UserPermition.show_Reports_every_serial:
        return "عرض تقرير صبات البلوكات";
      case UserPermition.allow_edit_in_details_blocks:
        return "امكانية التعديل فى تفاصيل البلوكات";
      case UserPermition.show_cusotmer_name_in_cutting_order:
        return "عرض اسم العميل فى اوامر التشغيل";
      case UserPermition.show_search_in_customers:
        return "عرض البحث فى العملاء";
      case UserPermition.show_date_in_invoices:
        return " التاريخ فى ازون التحميل";
      case UserPermition.delete_in_finalprodcut_details:
        return "المسح فى تفاصيل تام الصنع";
      case UserPermition.show_all:
        return "show_all";
      case UserPermition.show_block_incetion:
        return "اضافه الى البلوكات";
      case UserPermition.show_blockconsume:
        return "صرف بلوكات";
      case UserPermition.show_cutting_orders:
        return "اوامر التشغيل";
      case UserPermition.show_finalProdcut_stock:
        return "رصيد منتح تام";
      case UserPermition.show_finalprodcut_importedFormcuttingUint:
        return "وارد تام المقصات";
      case UserPermition.show_finalprodcut_invoice:
        return "اذون صرف منتج تام";
      case UserPermition.show_finalprodcut_invoicemaking:
        return "صرف منتج تام";
      case UserPermition.show_customers:
        return "العملاء";
      case UserPermition.show_massaging:
        return "المراسله والطلبات";
      case UserPermition.show_users_actions:
        return "show_users_actions";
      case UserPermition.show_scissors:
        return "المقصات";
      case UserPermition.show_Reports_finalprodcut:
        return "تقارير منتج تام";
      case UserPermition.show_Reports_final_prodcutscisors:
        return "تقارير منتج تام لكل مقص";
      case UserPermition.show_Reports_totals_of_blocks:
        return "تقارير اجماليات البلوكات";
      case UserPermition.show_Reports_consume_boock:
        return "تقارير صرف بلوكات";
      case UserPermition.show_Reports_details_of_block_stock:
        return "تفاصيل مخزن البلوكات";
      case UserPermition.show_Reports_details_of_finalProdcut_stock:
        return "تفاصيل مخزن منتج تام";
      case UserPermition.incert_in_finalProdcut_imorted:
        return "امكانيه الاضافه الى وارد تام المقصات";
      case UserPermition.incert_in_block_stock:
        return "امكانيه الاضافه الى مخزن البلوك";
      case UserPermition.fields_buttoms_consumeBlock:
        return "الزر والحقول فى صرف بلوكات";
      case UserPermition.incert_in_final_prodcutStock:
        return "امكانيه الاضافه الى مخزن المنتج التام";
      case UserPermition.incert_in_cutting_order:
        return "الاضافه الى اوامر التشغيل";
      case UserPermition.incert_in_customers:
        return "الاضافه الى العملاء";

      case UserPermition.delete_in_cutting_order:
        return "المسح او الاغلاق فى اوامر التشغيل";
      case UserPermition.delete_in_consume_block:
        return "المسح فى صرف بلوكات";
      case UserPermition.show_date_in_block_out_of_stock:
        return "التاريخ فى صرف البلوكات";
      case UserPermition.allow_edit_in_details_finalProdcut:
        return "التعديل فى تفاصيل منتج تام";
      case UserPermition.show_date_in_finalProduct_imported:
        return "التاريخ فى  وارد تام المقصات";
      case UserPermition.show_date_in_block_stock:
        return "التاريخ فى رصيد البلوكات";
      case UserPermition.can_print_in_cutting_order:
        return "امكانية الطباعه فى اوامر التشغيل";
      case UserPermition.can_close_in_cutting_order:
        return "امكانية الاغلاق فى اوامر التشغيل";
      case UserPermition.can_aprove_from_controll:
        return "امكانية الموافقه من جهة الكنترل";
      case UserPermition.can_aprove_from_quality:
        return "امكانية الموافقه من جهة الجوده";
      case UserPermition.can_aprove_from_recive_from_final_prodcut:
        return "امكانية الاستلام من جهة مخزن تام";
      case UserPermition.can_aprove_from_calculation:
        return "امكانية الموافقه من جهة الحسابات";
      case UserPermition.delete_in_imported_finalprodcut:
        return "امكانية المسح فى وارد تام المقصات";
      case UserPermition.incert_unregular_in_importedfinal_prodcut:
        return "اضافة مقاسات شاذه فى وارد تام المقصات";
      case UserPermition.show_not_final_stock:
        return "مخزن دون التام";
      case UserPermition.not_working:
        return "اخرى";
      case UserPermition.can_get_data_of_blocks:
        return "can_get_data_of_blocks";
      case UserPermition.can_get_data_of_final_prodcut:
        return "can_get_data_of_final_prodcut";
      case UserPermition.can_get_data_of_invoice:
        return "can_get_data_of_invoice";
      case UserPermition.can_get_data_of_customers:
        return "can_get_data_of_customers";
      case UserPermition.can_get_data_of_orders:
        return "can_get_data_of_orders";
      case UserPermition.can_get_data_of_fractions:
        return "can_get_data_of_fractions";
      case UserPermition.can_get_data_of_notfinals:
        return "can_get_data_of_notfinals";
    }
  }
}
