// ignore_for_file: file_names

import 'package:jason_company/ui/sH/h1_veiw.dart';
import 'package:jason_company/ui/sR/Rscissor_view.dart';

class ScissorsViewModel {
  List csissorsPages = [
    const H1Veiw(
      scissor: 1,
    ),
    const H1Veiw(
      scissor: 2,
    ),
    const H1Veiw(
      scissor: 3,
    ),
    Rscissor(scissor: 1),
    Rscissor(scissor: 2),
    Rscissor(scissor: 3),
  ];
}
