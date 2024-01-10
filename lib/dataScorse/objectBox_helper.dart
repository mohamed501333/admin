// ignore_for_file: file_names

import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/dataScorse/objectbox.g.dart';

class Database {
  late final Store store;
  late final Box<ChipBlockModel> blockchips;
  late final Box<ChipfinalProducut> finalproductschips;
  late final Box<ChipFraction> fractionchip;

  static Future<Database> create() async {
    final store = await openStore();
    return Database._createBoxes(store);
  }

  Database._createBoxes(this.store) {
    blockchips = Box<ChipBlockModel>(store);
    finalproductschips = Box<ChipfinalProducut>(store);
    fractionchip = Box<ChipFraction>(store);
  }
///////////////////////////////////
  // addBlock(BlockModel block) {
  //   blocksbox.put(block);
  // }

  // List<BlockModel> getblocks() {
  //   return blocksbox.getAll();
  // }

  // finishBloc(int id, int scissor) {
  //   BlockModel? x = blocksbox.get(id);
  //   x!.isfineshed = true;
  //   x.scissor = scissor;
  //   blocksbox.put(x);
  // }

  // unfinishBloc(
  //   int id,
  // ) {
  //   BlockModel? x = blocksbox.get(id);
  //   x!.isfineshed = false;
  //   x.scissor = 0;
  //   blocksbox.put(x);
  // }

  // consumeBlock(int id) {
  //   BlockModel? x = blocksbox.get(id);
  //   x!.consumed = true;
  //   blocksbox.put(x);
  // }

  // unconsumeBlock(
  //   int id,
  // ) {
  //   BlockModel? x = blocksbox.get(id);
  //   x!.consumed = false;
  //   blocksbox.put(x);
  // }

//     List<BlockModel> arrayOfDocs = querySnapshot.docs
//         .map((doc) => BlockModel.fromMap(doc.data()))
//         .toList();
//  }
//-------------------------------------------------------------------------------------------------

  // addFinalProuduct(FinalProductModel finalproduct) {
  //   finalproducts.put(finalproduct);
  // }
  // List<FinalProductModel> getFinalProuduct() {
  //   return Firebasecontroller().finalproducts;
  // }

  // deleteFinalProuduct(id) {
  //   finalproducts.remove(id);
  // }

  //////////////////////////////////////////////////////////

  // deleteFraction(List<int> ids) {
  //   fraction.removeMany(ids);
  // }

/////////////////////////////////////////
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

  addfinalProuductchips(ChipfinalProducut chip) {
    finalproductschips.put(chip);
  }

  List<ChipfinalProducut> getfinalProuductchips() {
    return finalproductschips.getAll();
  }

  deletefinalProuductchips(id) {
    finalproductschips.remove(id);
  }

  //////////////////////////////////////////////////////////

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
