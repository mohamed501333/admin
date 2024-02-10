import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/non_final_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:provider/provider.dart';

class NotFinalViewModer extends BaseViewModel {
  add(BuildContext context, String type) {
    if (formKey.currentState!.validate()) {
      NotFinalmodel input = NotFinalmodel(
        Hscissor: 0,
        Rscissor: 0,
        actions: [],
        id: DateTime.now().microsecondsSinceEpoch,
        date: DateTime.now(),
        wight: double.parse(wightcontroller.text),
        type: type,
      );
      context.read<NonFinalController>().add_to_not_FInals(input);
      clearfields();
    }
  }

  addwithMinus(BuildContext context, String type) {
    if (formKey.currentState!.validate()) {
      NotFinalmodel input = NotFinalmodel(
        Hscissor: 0,
        Rscissor: 0,
        actions: [],
        id: DateTime.now().microsecondsSinceEpoch,
        date: DateTime.now(),
        wight: -double.parse(wightcontroller.text),
        type: type,
      );
      context.read<NonFinalController>().add_to_not_FInals(input);

      clearfields();
    }
  }

  get(String v) {
    switch (v) {
      case "جوانب ":
        return "aspects";
      case "ارضيات":
        return "floors";
      case " هالك":
        return "Halek";
      case " درجة ثانيه":
        return "secondDegree";
      case " درجه ثانيه ممتازه":
        return "ExcellentsecondDegree";
    }
  }

//الحصول على البيانات
  data_for_type(
      BuildContext context, String type, List<NotFinalmodel> not_finals) {
    var a = not_finals
        .where((element) => element.type == get(type))
        .map((e) => e.wight);
    return a.isEmpty ? a : a.reduce((a, b) => a + b).removeTrailingZeros;
  }

  delete(BuildContext context, int id) {
    context.read<NonFinalController>().delete_not_FInals(id);
  }
}
