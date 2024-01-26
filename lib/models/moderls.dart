// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:objectbox/objectbox.dart';

class BlockModel {
  int id;
  String color;
  double density;
  String type;
  String serial;
  int number;
  int Rcissor;
  int Hscissor;
  int width;
  int lenth;
  int hight;
  double wight;
  String cumingFrom;
  String OutTo;
  String notes;
  String discreption;

  List<FractionModel> fractions;
  List<ActionModel> actions;
  List<NotFinalmodel> notfinals;

  BlockModel({
    required this.id,
    required this.color,
    required this.density,
    required this.type,
    required this.serial,
    required this.number,
    required this.Rcissor,
    required this.Hscissor,
    required this.width,
    required this.lenth,
    required this.hight,
    required this.wight,
    required this.cumingFrom,
    required this.OutTo,
    required this.notes,
    required this.discreption,
    required this.fractions,
    required this.actions,
    required this.notfinals,
  });

  //  horizontalscissor

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'color': color,
      'density': density,
      'type': type,
      'serial': serial,
      'number': number,
      'Rcissor': Rcissor,
      'Hscissor': Hscissor,
      'width': width,
      'lenth': lenth,
      'hight': hight,
      'wight': wight,
      'cumingFrom': cumingFrom,
      'OutTo': OutTo,
      'notes': notes,
      'discreption': discreption,
      'fractions': fractions.map((x) => x.toMap()).toList(),
      'actions': actions.map((x) => x.toMap()).toList(),
      'notfinals': notfinals.map((x) => x.toMap()).toList(),
    };
  }

  factory BlockModel.fromMap(Map<String, dynamic> map) {
    return BlockModel(
      id: map['id'] as int,
      color: map['color'] as String,
      density: map['density'] as double,
      type: map['type'] as String,
      serial: map['serial'] as String,
      number: map['number'] as int,
      Rcissor: map['Rcissor'] as int,
      Hscissor: map['Hscissor'] as int,
      width: map['width'] as int,
      lenth: map['lenth'] as int,
      hight: map['hight'] as int,
      wight: map['wight'] as double,
      cumingFrom: map['cumingFrom'] as String,
      OutTo: map['OutTo'] as String,
      notes: map['notes'] as String,
      discreption: map['discreption'] as String,
      fractions: List<FractionModel>.from(
        (map['fractions'] as List<dynamic>).map<FractionModel>(
          (x) => FractionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      notfinals: List<NotFinalmodel>.from(
        (map['notfinals'] as List<dynamic>).map<NotFinalmodel>(
          (x) => NotFinalmodel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BlockModel.fromJson(String source) =>
      BlockModel.fromMap(json.decode(source) as Map<String, dynamic>);

  BlockModel copyWith({
    int? id,
    String? color,
    double? density,
    String? type,
    String? serial,
    int? number,
    int? Rcissor,
    int? Hscissor,
    int? width,
    int? lenth,
    int? hight,
    double? wight,
    String? cumingFrom,
    String? OutTo,
    String? notes,
    String? discreption,
    List<FractionModel>? fractions,
    List<ActionModel>? actions,
    List<NotFinalmodel>? notfinals,
  }) {
    return BlockModel(
      id: id ?? this.id,
      color: color ?? this.color,
      density: density ?? this.density,
      type: type ?? this.type,
      serial: serial ?? this.serial,
      number: number ?? this.number,
      Rcissor: Rcissor ?? this.Rcissor,
      Hscissor: Hscissor ?? this.Hscissor,
      width: width ?? this.width,
      lenth: lenth ?? this.lenth,
      hight: hight ?? this.hight,
      wight: wight ?? this.wight,
      cumingFrom: cumingFrom ?? this.cumingFrom,
      OutTo: OutTo ?? this.OutTo,
      notes: notes ?? this.notes,
      discreption: discreption ?? this.discreption,
      fractions: fractions ?? this.fractions,
      actions: actions ?? this.actions,
      notfinals: notfinals ?? this.notfinals,
    );
  }

  @override
  String toString() {
    return 'BlockModel(id: $id, color: $color, density: $density, type: $type, serial: $serial, number: $number, Rcissor: $Rcissor, Hscissor: $Hscissor, width: $width, lenth: $lenth, hight: $hight, wight: $wight, cumingFrom: $cumingFrom, OutTo: $OutTo, notes: $notes, discreption: $discreption, fractions: $fractions, actions: $actions, notfinals: $notfinals)';
  }

  @override
  bool operator ==(covariant BlockModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.color == color &&
        other.density == density &&
        other.type == type &&
        other.serial == serial &&
        other.number == number &&
        other.Rcissor == Rcissor &&
        other.Hscissor == Hscissor &&
        other.width == width &&
        other.lenth == lenth &&
        other.hight == hight &&
        other.wight == wight &&
        other.cumingFrom == cumingFrom &&
        other.OutTo == OutTo &&
        other.notes == notes &&
        other.discreption == discreption &&
        listEquals(other.fractions, fractions) &&
        listEquals(other.actions, actions) &&
        listEquals(other.notfinals, notfinals);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        color.hashCode ^
        density.hashCode ^
        type.hashCode ^
        serial.hashCode ^
        number.hashCode ^
        Rcissor.hashCode ^
        Hscissor.hashCode ^
        width.hashCode ^
        lenth.hashCode ^
        hight.hashCode ^
        wight.hashCode ^
        cumingFrom.hashCode ^
        OutTo.hashCode ^
        notes.hashCode ^
        discreption.hashCode ^
        fractions.hashCode ^
        actions.hashCode ^
        notfinals.hashCode;
  }
}

class BlockModel2 {
  int id;
  String color;
  double density;
  String type;
  String serial;
  int number;
  int Rcissor;
  int Hscissor;
  int width;
  int lenth;
  int hight;
  double wight;
  String cumingFrom;
  String OutTo;
  String notes;

  List<FractionModel> fractions;
  List<ActionModel> actions;
  List<NotFinalmodel> notfinals;

  BlockModel2({
    required this.id,
    required this.color,
    required this.density,
    required this.type,
    required this.serial,
    required this.number,
    required this.Rcissor,
    required this.Hscissor,
    required this.width,
    required this.lenth,
    required this.hight,
    required this.wight,
    required this.cumingFrom,
    required this.OutTo,
    required this.notes,
    required this.fractions,
    required this.actions,
    required this.notfinals,
  });

  //  horizontalscissor

  BlockModel2 copyWith({
    int? id,
    String? color,
    double? density,
    String? type,
    String? serial,
    int? number,
    int? Rcissor,
    int? Hscissor,
    int? width,
    int? lenth,
    int? hight,
    double? wight,
    String? cumingFrom,
    String? OutTo,
    String? notes,
    List<FractionModel>? fractions,
    List<ActionModel>? actions,
    List<NotFinalmodel>? notfinals,
  }) {
    return BlockModel2(
      id: id ?? this.id,
      color: color ?? this.color,
      density: density ?? this.density,
      type: type ?? this.type,
      serial: serial ?? this.serial,
      number: number ?? this.number,
      Rcissor: Rcissor ?? this.Rcissor,
      Hscissor: Hscissor ?? this.Hscissor,
      width: width ?? this.width,
      lenth: lenth ?? this.lenth,
      hight: hight ?? this.hight,
      wight: wight ?? this.wight,
      cumingFrom: cumingFrom ?? this.cumingFrom,
      OutTo: OutTo ?? this.OutTo,
      notes: notes ?? this.notes,
      fractions: fractions ?? this.fractions,
      actions: actions ?? this.actions,
      notfinals: notfinals ?? this.notfinals,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'color': color,
      'density': density,
      'type': type,
      'serial': serial,
      'number': number,
      'Rcissor': Rcissor,
      'Hscissor': Hscissor,
      'width': width,
      'lenth': lenth,
      'hight': hight,
      'wight': wight,
      'cumingFrom': cumingFrom,
      'OutTo': OutTo,
      'notes': notes,
      'fractions': fractions.map((x) => x.toMap()).toList(),
      'actions': actions.map((x) => x.toMap()).toList(),
      'notfinals': notfinals.map((x) => x.toMap()).toList(),
    };
  }

  factory BlockModel2.fromMap(Map<String, dynamic> map) {
    return BlockModel2(
      id: map['id'] as int,
      color: map['color'] as String,
      density: map['density'] as double,
      type: map['type'] as String,
      serial: map['serial'] as String,
      number: map['number'] as int,
      Rcissor: map['Rcissor'] as int,
      Hscissor: map['Hscissor'] as int,
      width: map['width'] as int,
      lenth: map['lenth'] as int,
      hight: map['hight'] as int,
      wight: map['wight'] as double,
      cumingFrom: map['cumingFrom'] as String,
      OutTo: map['OutTo'] as String,
      notes: map['notes'] as String,
      fractions: List<FractionModel>.from(
        (map['fractions'] as List<dynamic>).map<FractionModel>(
          (x) => FractionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      notfinals: List<NotFinalmodel>.from(
        (map['notfinals'] as List<dynamic>).map<NotFinalmodel>(
          (x) => NotFinalmodel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BlockModel2.fromJson(String source) =>
      BlockModel2.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BlockModel2(id: $id, color: $color, density: $density, type: $type, serial: $serial, number: $number, Rcissor: $Rcissor, Hscissor: $Hscissor, width: $width, lenth: $lenth, hight: $hight, wight: $wight, cumingFrom: $cumingFrom, OutTo: $OutTo, notes: $notes, fractions: $fractions, actions: $actions, notfinals: $notfinals)';
  }

  @override
  bool operator ==(covariant BlockModel2 other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.color == color &&
        other.density == density &&
        other.type == type &&
        other.serial == serial &&
        other.number == number &&
        other.Rcissor == Rcissor &&
        other.Hscissor == Hscissor &&
        other.width == width &&
        other.lenth == lenth &&
        other.hight == hight &&
        other.wight == wight &&
        other.cumingFrom == cumingFrom &&
        other.OutTo == OutTo &&
        other.notes == notes &&
        listEquals(other.fractions, fractions) &&
        listEquals(other.actions, actions) &&
        listEquals(other.notfinals, notfinals);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        color.hashCode ^
        density.hashCode ^
        type.hashCode ^
        serial.hashCode ^
        number.hashCode ^
        Rcissor.hashCode ^
        Hscissor.hashCode ^
        width.hashCode ^
        lenth.hashCode ^
        hight.hashCode ^
        wight.hashCode ^
        cumingFrom.hashCode ^
        OutTo.hashCode ^
        notes.hashCode ^
        fractions.hashCode ^
        actions.hashCode ^
        notfinals.hashCode;
  }
}

class FractionModel {
  int id;
  int blockmodelmum;
  String serial;
  int wedth;
  int lenth;
  int hight;
  double density;
  String type;
  int Rscissor;
  int Hscissor;
  int Ascissor;
  int stage;
  String color;
  bool isfinished;
  String worker;
  String notes;
  List<NotFinalmodel> notfinals;
  List<ActionModel> actions;

  FractionModel({
    required this.id,
    required this.blockmodelmum,
    required this.serial,
    required this.wedth,
    required this.lenth,
    required this.hight,
    required this.density,
    required this.type,
    required this.Rscissor,
    required this.Hscissor,
    required this.Ascissor,
    required this.stage,
    required this.color,
    required this.isfinished,
    required this.worker,
    required this.notes,
    required this.notfinals,
    required this.actions,
  });

  FractionModel copyWith({
    int? id,
    int? blockmodelmum,
    String? serial,
    int? wedth,
    int? lenth,
    int? hight,
    double? density,
    String? type,
    int? Rscissor,
    int? Hscissor,
    int? Ascissor,
    int? stage,
    String? color,
    bool? isfinished,
    String? worker,
    String? notes,
    List<NotFinalmodel>? notfinals,
    List<ActionModel>? actions,
  }) {
    return FractionModel(
      id: id ?? this.id,
      blockmodelmum: blockmodelmum ?? this.blockmodelmum,
      serial: serial ?? this.serial,
      wedth: wedth ?? this.wedth,
      lenth: lenth ?? this.lenth,
      hight: hight ?? this.hight,
      density: density ?? this.density,
      type: type ?? this.type,
      Rscissor: Rscissor ?? this.Rscissor,
      Hscissor: Hscissor ?? this.Hscissor,
      Ascissor: Ascissor ?? this.Ascissor,
      stage: stage ?? this.stage,
      color: color ?? this.color,
      isfinished: isfinished ?? this.isfinished,
      worker: worker ?? this.worker,
      notes: notes ?? this.notes,
      notfinals: notfinals ?? this.notfinals,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'blockmodelmum': blockmodelmum,
      'serial': serial,
      'wedth': wedth,
      'lenth': lenth,
      'hight': hight,
      'density': density,
      'type': type,
      'Rscissor': Rscissor,
      'Hscissor': Hscissor,
      'Ascissor': Ascissor,
      'stage': stage,
      'color': color,
      'isfinished': isfinished,
      'worker': worker,
      'notes': notes,
      'notfinals': notfinals.map((x) => x.toMap()).toList(),
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory FractionModel.fromMap(Map<String, dynamic> map) {
    return FractionModel(
      id: map['id'] as int,
      blockmodelmum: map['blockmodelmum'] as int,
      serial: map['serial'] as String,
      wedth: map['wedth'] as int,
      lenth: map['lenth'] as int,
      hight: map['hight'] as int,
      density: map['density'] as double,
      type: map['type'] as String,
      Rscissor: map['Rscissor'] as int,
      Hscissor: map['Hscissor'] as int,
      Ascissor: map['Ascissor'] as int,
      stage: map['stage'] as int,
      color: map['color'] as String,
      isfinished: map['isfinished'] as bool,
      worker: map['worker'] as String,
      notes: map['notes'] as String,
      notfinals: List<NotFinalmodel>.from(
        (map['notfinals'] as List<dynamic>).map<NotFinalmodel>(
          (x) => NotFinalmodel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FractionModel.fromJson(String source) =>
      FractionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FractionModel(id: $id, blockmodelmum: $blockmodelmum, serial: $serial, wedth: $wedth, lenth: $lenth, hight: $hight, density: $density, type: $type, Rscissor: $Rscissor, Hscissor: $Hscissor, Ascissor: $Ascissor, stage: $stage, color: $color, isfinished: $isfinished, worker: $worker, notes: $notes, notfinals: $notfinals, actions: $actions)';
  }

  @override
  bool operator ==(covariant FractionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.blockmodelmum == blockmodelmum &&
        other.serial == serial &&
        other.wedth == wedth &&
        other.lenth == lenth &&
        other.hight == hight &&
        other.density == density &&
        other.type == type &&
        other.Rscissor == Rscissor &&
        other.Hscissor == Hscissor &&
        other.Ascissor == Ascissor &&
        other.stage == stage &&
        other.color == color &&
        other.isfinished == isfinished &&
        other.worker == worker &&
        other.notes == notes &&
        listEquals(other.notfinals, notfinals) &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        blockmodelmum.hashCode ^
        serial.hashCode ^
        wedth.hashCode ^
        lenth.hashCode ^
        hight.hashCode ^
        density.hashCode ^
        type.hashCode ^
        Rscissor.hashCode ^
        Hscissor.hashCode ^
        Ascissor.hashCode ^
        stage.hashCode ^
        color.hashCode ^
        isfinished.hashCode ^
        worker.hashCode ^
        notes.hashCode ^
        notfinals.hashCode ^
        actions.hashCode;
  }
}

class FinalProductModel {
  int stageOfR;
  int id;
  String color;
  bool isfinal;
  double density;
  String type;
  int amount;
  int scissor;
  int invoiceNum;
  double width;
  double lenth;
  double hight;
  double price;
  String customer;
  String worker;

  String notes;
  int cuting_order_number;
  List<ActionModel> actions;

  FinalProductModel({
    required this.stageOfR,
    required this.id,
    required this.color,
    required this.isfinal,
    required this.density,
    required this.type,
    required this.amount,
    required this.scissor,
    required this.invoiceNum,
    required this.width,
    required this.lenth,
    required this.hight,
    required this.price,
    required this.customer,
    required this.worker,
    required this.notes,
    required this.cuting_order_number,
    required this.actions,
  });

  FinalProductModel copyWith({
    int? stageOfR,
    int? id,
    String? color,
    bool? isfinal,
    double? density,
    String? type,
    int? amount,
    int? scissor,
    int? invoiceNum,
    double? width,
    double? lenth,
    double? hight,
    double? price,
    String? customer,
    String? worker,
    String? notes,
    int? cuting_order_number,
    List<ActionModel>? actions,
  }) {
    return FinalProductModel(
      stageOfR: stageOfR ?? this.stageOfR,
      id: id ?? this.id,
      color: color ?? this.color,
      isfinal: isfinal ?? this.isfinal,
      density: density ?? this.density,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      scissor: scissor ?? this.scissor,
      invoiceNum: invoiceNum ?? this.invoiceNum,
      width: width ?? this.width,
      lenth: lenth ?? this.lenth,
      hight: hight ?? this.hight,
      price: price ?? this.price,
      customer: customer ?? this.customer,
      worker: worker ?? this.worker,
      notes: notes ?? this.notes,
      cuting_order_number: cuting_order_number ?? this.cuting_order_number,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stageOfR': stageOfR,
      'id': id,
      'color': color,
      'isfinal': isfinal,
      'density': density,
      'type': type,
      'amount': amount,
      'scissor': scissor,
      'invoiceNum': invoiceNum,
      'width': width,
      'lenth': lenth,
      'hight': hight,
      'price': price,
      'customer': customer,
      'worker': worker,
      'notes': notes,
      'cuting_order_number': cuting_order_number,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory FinalProductModel.fromMap(Map<String, dynamic> map) {
    return FinalProductModel(
      stageOfR: map['stageOfR'] as int,
      id: map['id'] as int,
      color: map['color'] as String,
      isfinal: map['isfinal'] as bool,
      density: map['density'] as double,
      type: map['type'] as String,
      amount: map['amount'] as int,
      scissor: map['scissor'] as int,
      invoiceNum: map['invoiceNum'] as int,
      width: map['width'] as double,
      lenth: map['lenth'] as double,
      hight: map['hight'] as double,
      price: map['price'] as double,
      customer: map['customer'] as String,
      worker: map['worker'] as String,
      notes: map['notes'] as String,
      cuting_order_number: map['cuting_order_number'] as int,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FinalProductModel.fromJson(String source) =>
      FinalProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FinalProductModel2(stageOfR: $stageOfR, id: $id, color: $color, isfinal: $isfinal, density: $density, type: $type, amount: $amount, scissor: $scissor, invoiceNum: $invoiceNum, width: $width, lenth: $lenth, hight: $hight, price: $price, customer: $customer, worker: $worker, notes: $notes, cuting_order_number: $cuting_order_number, actions: $actions)';
  }

  @override
  bool operator ==(covariant FinalProductModel other) {
    if (identical(this, other)) return true;

    return other.stageOfR == stageOfR &&
        other.id == id &&
        other.color == color &&
        other.isfinal == isfinal &&
        other.density == density &&
        other.type == type &&
        other.amount == amount &&
        other.scissor == scissor &&
        other.invoiceNum == invoiceNum &&
        other.width == width &&
        other.lenth == lenth &&
        other.hight == hight &&
        other.price == price &&
        other.customer == customer &&
        other.worker == worker &&
        other.notes == notes &&
        other.cuting_order_number == cuting_order_number &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return stageOfR.hashCode ^
        id.hashCode ^
        color.hashCode ^
        isfinal.hashCode ^
        density.hashCode ^
        type.hashCode ^
        amount.hashCode ^
        scissor.hashCode ^
        invoiceNum.hashCode ^
        width.hashCode ^
        lenth.hashCode ^
        hight.hashCode ^
        price.hashCode ^
        customer.hashCode ^
        worker.hashCode ^
        notes.hashCode ^
        cuting_order_number.hashCode ^
        actions.hashCode;
  }
}

@Entity()
class ChipBlockModel {
  @Id()
  int id;
  final String title;
  final String color;
  final double density;
  final String type;
  final String serial;
  final double number;
  final double width;
  final double lenth;
  final double scissor;
  final double hight;
  final double wight;
  final String notes;
  final String description;
  ChipBlockModel({
    this.id = 0,
    required this.title,
    required this.color,
    required this.density,
    required this.type,
    required this.serial,
    required this.number,
    required this.width,
    required this.lenth,
    required this.scissor,
    required this.hight,
    required this.wight,
    required this.notes,
    required this.description,
  });

  ChipBlockModel copyWith({
    int? id,
    String? title,
    String? color,
    double? density,
    String? type,
    String? serial,
    double? number,
    double? width,
    double? lenth,
    double? scissor,
    double? hight,
    double? wight,
    String? notes,
    String? description,
  }) {
    return ChipBlockModel(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      density: density ?? this.density,
      type: type ?? this.type,
      serial: serial ?? this.serial,
      number: number ?? this.number,
      width: width ?? this.width,
      lenth: lenth ?? this.lenth,
      scissor: scissor ?? this.scissor,
      hight: hight ?? this.hight,
      wight: wight ?? this.wight,
      notes: notes ?? this.notes,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'color': color,
      'density': density,
      'type': type,
      'serial': serial,
      'number': number,
      'width': width,
      'lenth': lenth,
      'scissor': scissor,
      'hight': hight,
      'wight': wight,
      'notes': notes,
      'description': description,
    };
  }

  factory ChipBlockModel.fromMap(Map<String, dynamic> map) {
    return ChipBlockModel(
      id: map['id'] as int,
      title: map['title'] as String,
      color: map['color'] as String,
      density: map['density'] as double,
      type: map['type'] as String,
      serial: map['serial'] as String,
      number: map['number'] as double,
      width: map['width'] as double,
      lenth: map['lenth'] as double,
      scissor: map['scissor'] as double,
      hight: map['hight'] as double,
      wight: map['wight'] as double,
      notes: map['notes'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChipBlockModel.fromJson(String source) =>
      ChipBlockModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChipBlockModel(id: $id, title: $title, color: $color, density: $density, type: $type, serial: $serial, number: $number, width: $width, lenth: $lenth, scissor: $scissor, hight: $hight, wight: $wight, notes: $notes, description: $description)';
  }

  @override
  bool operator ==(covariant ChipBlockModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.color == color &&
        other.density == density &&
        other.type == type &&
        other.serial == serial &&
        other.number == number &&
        other.width == width &&
        other.lenth == lenth &&
        other.scissor == scissor &&
        other.hight == hight &&
        other.wight == wight &&
        other.notes == notes &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        color.hashCode ^
        density.hashCode ^
        type.hashCode ^
        serial.hashCode ^
        number.hashCode ^
        width.hashCode ^
        lenth.hashCode ^
        scissor.hashCode ^
        hight.hashCode ^
        wight.hashCode ^
        notes.hashCode ^
        description.hashCode;
  }
}

@Entity()
class ChipFraction {
  @Id()
  int id;
  final double width;
  final double lenth;
  final double hight;

  ChipFraction(
      {this.id = 0,
      required this.width,
      required this.lenth,
      required this.hight});
}

class NotFinalmodel {
  int id;
  DateTime date;
  double wight;
  String type;
  int Rscissor;
  int Hscissor;
  List<ActionModel> actions;
  NotFinalmodel({
    required this.id,
    required this.date,
    required this.wight,
    required this.type,
    required this.Rscissor,
    required this.Hscissor,
    required this.actions,
  });

  NotFinalmodel copyWith({
    int? id,
    DateTime? date,
    double? wight,
    String? type,
    String? worker,
    int? Rscissor,
    int? Hscissor,
    List<ActionModel>? actions,
  }) {
    return NotFinalmodel(
      id: id ?? this.id,
      date: date ?? this.date,
      wight: wight ?? this.wight,
      type: type ?? this.type,
      Rscissor: Rscissor ?? this.Rscissor,
      Hscissor: Hscissor ?? this.Hscissor,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'wight': wight,
      'type': type,
      'Rscissor': Rscissor,
      'Hscissor': Hscissor,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory NotFinalmodel.fromMap(Map<String, dynamic> map) {
    return NotFinalmodel(
      id: map['id'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      wight: map['wight'] as double,
      type: map['type'] as String,
      Rscissor: map['Rscissor'] as int,
      Hscissor: map['Hscissor'] as int,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotFinalmodel.fromJson(String source) =>
      NotFinalmodel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotFinalmodel(id: $id, date: $date, wight: $wight, type: $type, Rscissor: $Rscissor, Hscissor: $Hscissor, actions: $actions)';
  }

  @override
  bool operator ==(covariant NotFinalmodel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.date == date &&
        other.wight == wight &&
        other.type == type &&
        other.Rscissor == Rscissor &&
        other.Hscissor == Hscissor &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        wight.hashCode ^
        type.hashCode ^
        Rscissor.hashCode ^
        Hscissor.hashCode ^
        actions.hashCode;
  }
}

class ActionModel {
  String action;
  String who;
  DateTime when;
  ActionModel({
    required this.action,
    required this.who,
    required this.when,
  });

  ActionModel copyWith({
    String? action,
    String? who,
    DateTime? when,
  }) {
    return ActionModel(
      action: action ?? this.action,
      who: who ?? this.who,
      when: when ?? this.when,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'action': action,
      'who': who,
      'when': when.millisecondsSinceEpoch,
    };
  }

  factory ActionModel.fromMap(Map<String, dynamic> map) {
    return ActionModel(
      action: map['action'] as String,
      who: map['who'] as String,
      when: DateTime.fromMillisecondsSinceEpoch(map['when'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ActionModel.fromJson(String source) =>
      ActionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ActionModel(action: $action, who: $who, when: $when)';

  @override
  bool operator ==(covariant ActionModel other) {
    if (identical(this, other)) return true;

    return other.action == action && other.who == who && other.when == when;
  }

  @override
  int get hashCode => action.hashCode ^ who.hashCode ^ when.hashCode;
}

class Invoice {
  final int id;
  final int number;
  final DateTime date;
  final String driverName;
  final int carNumber;
  final String makeLoad;
  final String notes;
  final List<ActionModel> actions;
  final List<InvoiceItem> items;
  Invoice({
    required this.id,
    required this.number,
    required this.date,
    required this.driverName,
    required this.carNumber,
    required this.makeLoad,
    required this.notes,
    required this.actions,
    required this.items,
  });

  Invoice copyWith({
    int? id,
    int? number,
    DateTime? date,
    String? driverName,
    int? carNumber,
    String? makeLoad,
    String? notes,
    List<ActionModel>? actions,
    List<InvoiceItem>? items,
  }) {
    return Invoice(
      id: id ?? this.id,
      number: number ?? this.number,
      date: date ?? this.date,
      driverName: driverName ?? this.driverName,
      carNumber: carNumber ?? this.carNumber,
      makeLoad: makeLoad ?? this.makeLoad,
      notes: notes ?? this.notes,
      actions: actions ?? this.actions,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'number': number,
      'date': date.millisecondsSinceEpoch,
      'driverName': driverName,
      'carNumber': carNumber,
      'makeLoad': makeLoad,
      'notes': notes,
      'actions': actions.map((x) => x.toMap()).toList(),
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      id: map['id'] as int,
      number: map['number'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      driverName: map['driverName'] as String,
      carNumber: map['carNumber'] as int,
      makeLoad: map['makeLoad'] as String,
      notes: map['notes'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      items: List<InvoiceItem>.from(
        (map['items'] as List<dynamic>).map<InvoiceItem>(
          (x) => InvoiceItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Invoice.fromJson(String source) =>
      Invoice.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Invoice(id: $id, number: $number, date: $date, driverName: $driverName, carNumber: $carNumber, makeLoad: $makeLoad, notes: $notes, actions: $actions, items: $items)';
  }

  @override
  bool operator ==(covariant Invoice other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.number == number &&
        other.date == date &&
        other.driverName == driverName &&
        other.carNumber == carNumber &&
        other.makeLoad == makeLoad &&
        other.notes == notes &&
        listEquals(other.actions, actions) &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        number.hashCode ^
        date.hashCode ^
        driverName.hashCode ^
        carNumber.hashCode ^
        makeLoad.hashCode ^
        notes.hashCode ^
        actions.hashCode ^
        items.hashCode;
  }
}

class InvoiceItem {
  double lenth;
  double width;
  double hight;
  double wight;
  String color;
  double density;
  String customer;
  int amount;

  InvoiceItem({
    required this.lenth,
    required this.width,
    required this.hight,
    required this.wight,
    required this.color,
    required this.density,
    required this.customer,
    required this.amount,
  });

  InvoiceItem copyWith({
    double? lenth,
    double? width,
    double? hight,
    double? wight,
    String? color,
    double? density,
    String? customer,
    int? amount,
  }) {
    return InvoiceItem(
      lenth: lenth ?? this.lenth,
      width: width ?? this.width,
      hight: hight ?? this.hight,
      wight: wight ?? this.wight,
      color: color ?? this.color,
      density: density ?? this.density,
      customer: customer ?? this.customer,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lenth': lenth,
      'width': width,
      'hight': hight,
      'wight': wight,
      'color': color,
      'density': density,
      'customer': customer,
      'amount': amount,
    };
  }

  factory InvoiceItem.fromMap(Map<String, dynamic> map) {
    return InvoiceItem(
      lenth: map['lenth'] as double,
      width: map['width'] as double,
      hight: map['hight'] as double,
      wight: map['wight'] as double,
      color: map['color'] as String,
      density: map['density'] as double,
      customer: map['customer'] as String,
      amount: map['amount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceItem.fromJson(String source) =>
      InvoiceItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InvoiceItem(lenth: $lenth, width: $width, hight: $hight, wight: $wight, color: $color, density: $density, customer: $customer, amount: $amount)';
  }

  @override
  bool operator ==(covariant InvoiceItem other) {
    if (identical(this, other)) return true;

    return other.lenth == lenth &&
        other.width == width &&
        other.hight == hight &&
        other.wight == wight &&
        other.color == color &&
        other.density == density &&
        other.customer == customer &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return lenth.hashCode ^
        width.hashCode ^
        hight.hashCode ^
        wight.hashCode ^
        color.hashCode ^
        density.hashCode ^
        customer.hashCode ^
        amount.hashCode;
  }
}

class CustomerModel {
  int id;
  int serial;
  String name;
  List<ActionModel> actions;

  CustomerModel({
    required this.id,
    required this.serial,
    required this.name,
    required this.actions,
  });

  CustomerModel copyWith({
    int? id,
    int? serial,
    String? name,
    List<ActionModel>? actions,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      serial: serial ?? this.serial,
      name: name ?? this.name,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'serial': serial,
      'name': name,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] as int,
      serial: map['serial'] as int,
      name: map['name'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomerModel(id: $id, serial: $serial, name: $name, actions: $actions)';
  }

  @override
  bool operator ==(covariant CustomerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.serial == serial &&
        other.name == name &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return id.hashCode ^ serial.hashCode ^ name.hashCode ^ actions.hashCode;
  }
}

class OrderModel {
  int id;
  int serial;
  DateTime datecreated;
  DateTime dateTOOrder;
  String customer;
  List<ActionModel> actions;
  List<OperationOrederItems> items;
  String notes;
  OrderModel({
    required this.id,
    required this.serial,
    required this.datecreated,
    required this.dateTOOrder,
    required this.customer,
    required this.actions,
    required this.notes,
    required this.items,
  });

  OrderModel copyWith({
    int? id,
    int? serial,
    DateTime? datecreated,
    DateTime? dateTOOrder,
    String? customer,
    List<ActionModel>? actions,
    String? notes,
    List<OperationOrederItems>? items,
  }) {
    return OrderModel(
      id: id ?? this.id,
      serial: serial ?? this.serial,
      datecreated: datecreated ?? this.datecreated,
      dateTOOrder: dateTOOrder ?? this.dateTOOrder,
      customer: customer ?? this.customer,
      actions: actions ?? this.actions,
      items: items ?? this.items,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'serial': serial,
      'datecreated': datecreated.millisecondsSinceEpoch,
      'dateTOOrder': dateTOOrder.millisecondsSinceEpoch,
      'customer': customer,
      'notes': notes,
      'actions': actions.map((x) => x.toMap()).toList(),
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as int,
      serial: map['serial'] as int,
      datecreated:
          DateTime.fromMillisecondsSinceEpoch(map['datecreated'] as int),
      dateTOOrder:
          DateTime.fromMillisecondsSinceEpoch(map['dateTOOrder'] as int),
      customer: map['customer'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      items: List<OperationOrederItems>.from(
        (map['items'] as List<dynamic>).map<OperationOrederItems>(
          (x) => OperationOrederItems.fromMap(x as Map<String, dynamic>),
        ),
      ),
      notes: map['notes'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(id: $id, serial: $serial, datecreated: $datecreated, dateTOOrder: $dateTOOrder, customer: $customer, actions: $actions, items: $items, notes: $notes)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.serial == serial &&
        other.datecreated == datecreated &&
        other.dateTOOrder == dateTOOrder &&
        other.customer == customer &&
        listEquals(other.actions, actions) &&
        listEquals(other.items, items) &&
        other.notes == notes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        serial.hashCode ^
        datecreated.hashCode ^
        dateTOOrder.hashCode ^
        customer.hashCode ^
        actions.hashCode ^
        items.hashCode ^
        notes.hashCode;
  }
}

class OperationOrederItems {
  int id;
  String color;
  String type;
  double density;
  double lenth;
  double widti;
  double hight;
  int Qantity;
  OperationOrederItems({
    required this.id,
    required this.color,
    required this.type,
    required this.density,
    required this.lenth,
    required this.widti,
    required this.hight,
    required this.Qantity,
  });

  OperationOrederItems copyWith({
    int? id,
    String? color,
    String? type,
    double? density,
    double? lenth,
    double? widti,
    double? hight,
    int? Qantity,
  }) {
    return OperationOrederItems(
      id: id ?? this.id,
      color: color ?? this.color,
      type: type ?? this.type,
      density: density ?? this.density,
      lenth: lenth ?? this.lenth,
      widti: widti ?? this.widti,
      hight: hight ?? this.hight,
      Qantity: Qantity ?? this.Qantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'color': color,
      'type': type,
      'density': density,
      'lenth': lenth,
      'widti': widti,
      'hight': hight,
      'Qantity': Qantity,
    };
  }

  factory OperationOrederItems.fromMap(Map<String, dynamic> map) {
    return OperationOrederItems(
      id: map['id'] as int,
      color: map['color'] as String,
      type: map['type'] as String,
      density: map['density'] as double,
      lenth: map['lenth'] as double,
      widti: map['widti'] as double,
      hight: map['hight'] as double,
      Qantity: map['Qantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OperationOrederItems.fromJson(String source) =>
      OperationOrederItems.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OperationOrederItems(id: $id, color: $color, type: $type, density: $density, lenth: $lenth, widti: $widti, hight: $hight, Qantity: $Qantity)';
  }

  @override
  bool operator ==(covariant OperationOrederItems other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.color == color &&
        other.type == type &&
        other.density == density &&
        other.lenth == lenth &&
        other.widti == widti &&
        other.hight == hight &&
        other.Qantity == Qantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        color.hashCode ^
        type.hashCode ^
        density.hashCode ^
        lenth.hashCode ^
        widti.hashCode ^
        hight.hashCode ^
        Qantity.hashCode;
  }
}

class Users {
  int id;
  String uidemail;
  String uid;
  String name;
  List<UserpermitionTittle> permitions;
  Users({
    required this.id,
    required this.uidemail,
    required this.uid,
    required this.name,
    required this.permitions,
  });

  Users copyWith({
    int? id,
    String? uidemail,
    String? uid,
    String? name,
    List<UserpermitionTittle>? permitions,
  }) {
    return Users(
      id: id ?? this.id,
      uidemail: uidemail ?? this.uidemail,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      permitions: permitions ?? this.permitions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uidemail': uidemail,
      'uid': uid,
      'name': name,
      'permitions': permitions.map((x) => x.toMap()).toList(),
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] as int,
      uidemail: map['uidemail'] as String,
      uid: map['uid'] as String,
      name: map['name'] as String,
      permitions: List<UserpermitionTittle>.from(
        (map['permitions'] as List<dynamic>).map<UserpermitionTittle>(
          (x) => UserpermitionTittle.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) =>
      Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Users(id: $id, uidemail: $uidemail, uid: $uid, name: $name, permitions: $permitions)';
  }

  @override
  bool operator ==(covariant Users other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.uidemail == uidemail &&
        other.uid == uid &&
        other.name == name &&
        listEquals(other.permitions, permitions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uidemail.hashCode ^
        uid.hashCode ^
        name.hashCode ^
        permitions.hashCode;
  }
}

class UserpermitionTittle {
  String tittle;
  UserpermitionTittle({
    required this.tittle,
  });

  UserpermitionTittle copyWith({
    String? tittle,
  }) {
    return UserpermitionTittle(
      tittle: tittle ?? this.tittle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tittle': tittle,
    };
  }

  factory UserpermitionTittle.fromMap(Map<String, dynamic> map) {
    return UserpermitionTittle(
      tittle: map['tittle'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserpermitionTittle.fromJson(String source) =>
      UserpermitionTittle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserpermitionTittle(tittle: $tittle)';

  @override
  bool operator ==(covariant UserpermitionTittle other) {
    if (identical(this, other)) return true;

    return other.tittle == tittle;
  }

  @override
  int get hashCode => tittle.hashCode;
}
