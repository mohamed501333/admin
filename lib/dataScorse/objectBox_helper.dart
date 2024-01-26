// ignore_for_file: file_names

import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/dataScorse/objectbox.g.dart';

class Database {
  late final Store store;
  late final Box<ChipBlockModel> blockchips;
  late final Box<ChipFraction> fractionchip;

  static Future<Database> create() async {
    final store = await openStore();
    return Database._createBoxes(store);
  }

  Database._createBoxes(this.store) {
    blockchips = Box<ChipBlockModel>(store);
    fractionchip = Box<ChipFraction>(store);
  }

  addchips(ChipBlockModel chip) {
    blockchips.put(chip);
  }

  List<ChipBlockModel> getchips() {
    return blockchips.getAll();
  }

  deletechip(id) {
    blockchips.remove(id);
  }
///////////////////////////////////////////

  addFractionchip(ChipFraction fract) {
    fractionchip.put(fract);
  }

  List<ChipFraction> getFractionchip() {
    return fractionchip.getAll();
  }

  deleteFractionchip(id) {
    fractionchip.remove(id);
  }
}
