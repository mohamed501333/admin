// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, camel_case_types

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

class FractionModel {
  int id;
  int blockmodelmum;
  int blockId;
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
    required this.blockId,
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
    int? blockId,
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
      blockId: blockId ?? this.blockId,
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
      'blockId': blockId,
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
      blockId: map['blockId'] as int,
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
    return 'FractionModel(id: $id, blockmodelmum: $blockmodelmum, blockId: $blockId, serial: $serial, wedth: $wedth, lenth: $lenth, hight: $hight, density: $density, type: $type, Rscissor: $Rscissor, Hscissor: $Hscissor, Ascissor: $Ascissor, stage: $stage, color: $color, isfinished: $isfinished, worker: $worker, notes: $notes, notfinals: $notfinals, actions: $actions)';
  }

  @override
  bool operator ==(covariant FractionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.blockmodelmum == blockmodelmum &&
        other.blockId == blockId &&
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
        blockId.hashCode ^
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
  int id;
  String color;
  bool isfinal;
  double density;
  String type;
  int amount;
  int scissor;
  int stageOfR;

  int invoiceNum;
  double width;
  double lenth;
  double hight;
  double volume;
  double whight;
  double price;
  String customer;
  String worker;

  String notes;
  int cuting_order_number;
  List<ActionModel> actions;
  FinalProductModel({
    required this.id,
    required this.color,
    required this.isfinal,
    required this.density,
    required this.type,
    required this.amount,
    required this.scissor,
    required this.stageOfR,
    required this.invoiceNum,
    required this.width,
    required this.lenth,
    required this.hight,
    required this.volume,
    required this.whight,
    required this.price,
    required this.customer,
    required this.worker,
    required this.notes,
    required this.cuting_order_number,
    required this.actions,
  });

  FinalProductModel copyWith({
    int? id,
    String? color,
    bool? isfinal,
    double? density,
    String? type,
    int? amount,
    int? scissor,
    int? stageOfR,
    int? invoiceNum,
    double? width,
    double? lenth,
    double? hight,
    double? volume,
    double? whight,
    double? price,
    String? customer,
    String? worker,
    String? notes,
    int? cuting_order_number,
    List<ActionModel>? actions,
  }) {
    return FinalProductModel(
      id: id ?? this.id,
      color: color ?? this.color,
      isfinal: isfinal ?? this.isfinal,
      density: density ?? this.density,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      scissor: scissor ?? this.scissor,
      stageOfR: stageOfR ?? this.stageOfR,
      invoiceNum: invoiceNum ?? this.invoiceNum,
      width: width ?? this.width,
      lenth: lenth ?? this.lenth,
      hight: hight ?? this.hight,
      volume: volume ?? this.volume,
      whight: whight ?? this.whight,
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
      'id': id,
      'color': color,
      'isfinal': isfinal,
      'density': density,
      'type': type,
      'amount': amount,
      'scissor': scissor,
      'stageOfR': stageOfR,
      'invoiceNum': invoiceNum,
      'width': width,
      'lenth': lenth,
      'hight': hight,
      'volume': volume,
      'whight': whight,
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
      id: map['id'] as int,
      color: map['color'] as String,
      isfinal: map['isfinal'] as bool,
      density: map['density'] as double,
      type: map['type'] as String,
      amount: map['amount'] as int,
      scissor: map['scissor'] as int,
      stageOfR: map['stageOfR'] as int,
      invoiceNum: map['invoiceNum'] as int,
      width: map['width'] as double,
      lenth: map['lenth'] as double,
      hight: map['hight'] as double,
      volume: map['volume'] as double,
      whight: map['whight'] as double,
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
    return 'FinalProductModel(id: $id, color: $color, isfinal: $isfinal, density: $density, type: $type, amount: $amount, scissor: $scissor, stageOfR: $stageOfR, invoiceNum: $invoiceNum, width: $width, lenth: $lenth, hight: $hight, volume: $volume, whight: $whight, price: $price, customer: $customer, worker: $worker, notes: $notes, cuting_order_number: $cuting_order_number, actions: $actions)';
  }

  @override
  bool operator ==(covariant FinalProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.color == color &&
        other.isfinal == isfinal &&
        other.density == density &&
        other.type == type &&
        other.amount == amount &&
        other.scissor == scissor &&
        other.stageOfR == stageOfR &&
        other.invoiceNum == invoiceNum &&
        other.width == width &&
        other.lenth == lenth &&
        other.hight == hight &&
        other.volume == volume &&
        other.whight == whight &&
        other.price == price &&
        other.customer == customer &&
        other.worker == worker &&
        other.notes == notes &&
        other.cuting_order_number == cuting_order_number &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        color.hashCode ^
        isfinal.hashCode ^
        density.hashCode ^
        type.hashCode ^
        amount.hashCode ^
        scissor.hashCode ^
        stageOfR.hashCode ^
        invoiceNum.hashCode ^
        width.hashCode ^
        lenth.hashCode ^
        hight.hashCode ^
        volume.hashCode ^
        whight.hashCode ^
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
  final double biscole;
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
    required this.biscole,
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
    double? biscole,
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
      biscole: biscole ?? this.biscole,
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
      'biscole': biscole,
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
      biscole: map['biscole'] as double,
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
    return 'Invoice(id: $id, number: $number, date: $date, driverName: $driverName, carNumber: $carNumber, makeLoad: $makeLoad, notes: $notes, biscole: $biscole, actions: $actions, items: $items)';
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
        other.biscole == biscole &&
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
        biscole.hashCode ^
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
  double price;
  String customer;
  int amount;
  InvoiceItem({
    required this.lenth,
    required this.width,
    required this.hight,
    required this.wight,
    required this.color,
    required this.density,
    required this.price,
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
    double? price,
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
      price: price ?? this.price,
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
      'price': price,
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
      price: map['price'] as double,
      customer: map['customer'] as String,
      amount: map['amount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceItem.fromJson(String source) =>
      InvoiceItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InvoiceItem(lenth: $lenth, width: $width, hight: $hight, wight: $wight, color: $color, density: $density, price: $price, customer: $customer, amount: $amount)';
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
        other.price == price &&
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
        price.hashCode ^
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

class BlockCategory {
  int id;
  String description;
  String type;
  String density;
  String color;
  List<ActionModel> actions;
  BlockCategory({
    required this.id,
    required this.description,
    required this.type,
    required this.density,
    required this.color,
    required this.actions,
  });

  BlockCategory copyWith({
    int? id,
    String? description,
    String? type,
    String? density,
    String? color,
    List<ActionModel>? actions,
  }) {
    return BlockCategory(
      id: id ?? this.id,
      description: description ?? this.description,
      type: type ?? this.type,
      density: density ?? this.density,
      color: color ?? this.color,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'type': type,
      'density': density,
      'color': color,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory BlockCategory.fromMap(Map<String, dynamic> map) {
    return BlockCategory(
      id: map['id'] as int,
      description: map['description'] as String,
      type: map['type'] as String,
      density: map['density'] as String,
      color: map['color'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BlockCategory.fromJson(String source) =>
      BlockCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BlockCategory(id: $id, description: $description, type: $type, density: $density, color: $color, actions: $actions)';
  }

  @override
  bool operator ==(covariant BlockCategory other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.description == description &&
        other.type == type &&
        other.density == density &&
        other.color == color &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        type.hashCode ^
        density.hashCode ^
        color.hashCode ^
        actions.hashCode;
  }
}

class ChemicalsModel {
  int id;
  String family;
  String name;
  String unit;
  double quantityForSingleUnit;
  int supplyOrderNum;
  int StockRequisitionNum;
  double quantity;
  double Totalquantity;
  String description;
  String notes;
  String cumingFrom;
  String outTo;
  List<ActionModel> actions;
  ChemicalsModel({
    required this.id,
    required this.family,
    required this.name,
    required this.unit,
    required this.quantityForSingleUnit,
    required this.supplyOrderNum,
    required this.StockRequisitionNum,
    required this.quantity,
    required this.Totalquantity,
    required this.description,
    required this.notes,
    required this.cumingFrom,
    required this.outTo,
    required this.actions,
  });

  ChemicalsModel copyWith({
    int? id,
    String? family,
    String? name,
    String? unit,
    double? quantityForSingleUnit,
    int? supplyOrderNum,
    int? StockRequisitionNum,
    double? quantity,
    double? Totalquantity,
    String? description,
    String? notes,
    String? cumingFrom,
    String? outTo,
    List<ActionModel>? actions,
  }) {
    return ChemicalsModel(
      id: id ?? this.id,
      family: family ?? this.family,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      quantityForSingleUnit:
          quantityForSingleUnit ?? this.quantityForSingleUnit,
      supplyOrderNum: supplyOrderNum ?? this.supplyOrderNum,
      StockRequisitionNum: StockRequisitionNum ?? this.StockRequisitionNum,
      quantity: quantity ?? this.quantity,
      Totalquantity: Totalquantity ?? this.Totalquantity,
      description: description ?? this.description,
      notes: notes ?? this.notes,
      cumingFrom: cumingFrom ?? this.cumingFrom,
      outTo: outTo ?? this.outTo,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'family': family,
      'name': name,
      'unit': unit,
      'quantityForSingleUnit': quantityForSingleUnit,
      'supplyOrderNum': supplyOrderNum,
      'StockRequisitionNum': StockRequisitionNum,
      'quantity': quantity,
      'Totalquantity': Totalquantity,
      'description': description,
      'notes': notes,
      'cumingFrom': cumingFrom,
      'outTo': outTo,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory ChemicalsModel.fromMap(Map<String, dynamic> map) {
    return ChemicalsModel(
      id: map['id'] as int,
      family: map['family'] as String,
      name: map['name'] as String,
      unit: map['unit'] as String,
      quantityForSingleUnit: map['quantityForSingleUnit'] as double,
      supplyOrderNum: map['supplyOrderNum'] as int,
      StockRequisitionNum: map['StockRequisitionNum'] as int,
      quantity: map['quantity'] as double,
      Totalquantity: map['Totalquantity'] as double,
      description: map['description'] as String,
      notes: map['notes'] as String,
      cumingFrom: map['cumingFrom'] as String,
      outTo: map['outTo'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChemicalsModel.fromJson(String source) =>
      ChemicalsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChemicalsModel(id: $id, family: $family, name: $name, unit: $unit, quantityForSingleUnit: $quantityForSingleUnit, supplyOrderNum: $supplyOrderNum, StockRequisitionNum: $StockRequisitionNum, quantity: $quantity, Totalquantity: $Totalquantity, description: $description, notes: $notes, cumingFrom: $cumingFrom, outTo: $outTo, actions: $actions)';
  }

  @override
  bool operator ==(covariant ChemicalsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.family == family &&
        other.name == name &&
        other.unit == unit &&
        other.quantityForSingleUnit == quantityForSingleUnit &&
        other.supplyOrderNum == supplyOrderNum &&
        other.StockRequisitionNum == StockRequisitionNum &&
        other.quantity == quantity &&
        other.Totalquantity == Totalquantity &&
        other.description == description &&
        other.notes == notes &&
        other.cumingFrom == cumingFrom &&
        other.outTo == outTo &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        family.hashCode ^
        name.hashCode ^
        unit.hashCode ^
        quantityForSingleUnit.hashCode ^
        supplyOrderNum.hashCode ^
        StockRequisitionNum.hashCode ^
        quantity.hashCode ^
        Totalquantity.hashCode ^
        description.hashCode ^
        notes.hashCode ^
        cumingFrom.hashCode ^
        outTo.hashCode ^
        actions.hashCode;
  }
}

class ChemicalCategory {
  int id;

  String family;

  String item;

  String unit;
  String cummingFrom;
  String OutTo;
  double quantityForUnit;

  List<ActionModel> actions;
  ChemicalCategory({
    required this.id,
    required this.family,
    required this.item,
    required this.unit,
    required this.cummingFrom,
    required this.OutTo,
    required this.quantityForUnit,
    required this.actions,
  });

  ChemicalCategory copyWith({
    int? id,
    String? family,
    String? item,
    String? unit,
    String? cummingFrom,
    String? OutTo,
    double? quantityForUnit,
    List<ActionModel>? actions,
  }) {
    return ChemicalCategory(
      id: id ?? this.id,
      family: family ?? this.family,
      item: item ?? this.item,
      unit: unit ?? this.unit,
      cummingFrom: cummingFrom ?? this.cummingFrom,
      OutTo: OutTo ?? this.OutTo,
      quantityForUnit: quantityForUnit ?? this.quantityForUnit,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'family': family,
      'item': item,
      'unit': unit,
      'cummingFrom': cummingFrom,
      'OutTo': OutTo,
      'quantityForUnit': quantityForUnit,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory ChemicalCategory.fromMap(Map<String, dynamic> map) {
    return ChemicalCategory(
      id: map['id'] as int,
      family: map['family'] as String,
      item: map['item'] as String,
      unit: map['unit'] as String,
      cummingFrom: map['cummingFrom'] as String,
      OutTo: map['OutTo'] as String,
      quantityForUnit: map['quantityForUnit'] as double,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChemicalCategory.fromJson(String source) =>
      ChemicalCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChemicalCategory(id: $id, family: $family, item: $item, unit: $unit, cummingFrom: $cummingFrom, OutTo: $OutTo, quantityForUnit: $quantityForUnit, actions: $actions)';
  }

  @override
  bool operator ==(covariant ChemicalCategory other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.family == family &&
        other.item == item &&
        other.unit == unit &&
        other.cummingFrom == cummingFrom &&
        other.OutTo == OutTo &&
        other.quantityForUnit == quantityForUnit &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        family.hashCode ^
        item.hashCode ^
        unit.hashCode ^
        cummingFrom.hashCode ^
        OutTo.hashCode ^
        quantityForUnit.hashCode ^
        actions.hashCode;
  }
}

class PurcheItem {
  int item_Id;
  int purcheOrder_Id;
  double quantity;
  String Unit;
  String item;
  String note;
  String receiver;
  double lastPrice;

  final List<ActionModel> actions;
  final List<PurcheItemOffers> offers;
  PurcheItem({
    required this.item_Id,
    required this.purcheOrder_Id,
    required this.quantity,
    required this.Unit,
    required this.item,
    required this.note,
    required this.receiver,
    required this.lastPrice,
    required this.actions,
    required this.offers,
  });

  PurcheItem copyWith({
    int? item_Id,
    int? purcheOrder_Id,
    double? quantity,
    String? Unit,
    String? item,
    String? note,
    String? receiver,
    double? lastPrice,
    List<ActionModel>? actions,
    List<PurcheItemOffers>? offers,
  }) {
    return PurcheItem(
      item_Id: item_Id ?? this.item_Id,
      purcheOrder_Id: purcheOrder_Id ?? this.purcheOrder_Id,
      quantity: quantity ?? this.quantity,
      Unit: Unit ?? this.Unit,
      item: item ?? this.item,
      note: note ?? this.note,
      receiver: receiver ?? this.receiver,
      lastPrice: lastPrice ?? this.lastPrice,
      actions: actions ?? this.actions,
      offers: offers ?? this.offers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_Id': item_Id,
      'purcheOrder_Id': purcheOrder_Id,
      'quantity': quantity,
      'Unit': Unit,
      'item': item,
      'note': note,
      'receiver': receiver,
      'lastPrice': lastPrice,
      'actions': actions.map((x) => x.toMap()).toList(),
      'offers': offers.map((x) => x.toMap()).toList(),
    };
  }

  factory PurcheItem.fromMap(Map<String, dynamic> map) {
    return PurcheItem(
      item_Id: map['item_Id'] as int,
      purcheOrder_Id: map['purcheOrder_Id'] as int,
      quantity: map['quantity'] as double,
      Unit: map['Unit'] as String,
      item: map['item'] as String,
      note: map['note'] as String,
      receiver: map['receiver'] as String,
      lastPrice: map['lastPrice'] as double,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      offers: List<PurcheItemOffers>.from(
        (map['offers'] as List<dynamic>).map<PurcheItemOffers>(
          (x) => PurcheItemOffers.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PurcheItem.fromJson(String source) =>
      PurcheItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PurcheItem(item_Id: $item_Id, purcheOrder_Id: $purcheOrder_Id, quantity: $quantity, Unit: $Unit, item: $item, note: $note, receiver: $receiver, lastPrice: $lastPrice, actions: $actions, offers: $offers)';
  }

  @override
  bool operator ==(covariant PurcheItem other) {
    if (identical(this, other)) return true;

    return other.item_Id == item_Id &&
        other.purcheOrder_Id == purcheOrder_Id &&
        other.quantity == quantity &&
        other.Unit == Unit &&
        other.item == item &&
        other.note == note &&
        other.receiver == receiver &&
        other.lastPrice == lastPrice &&
        listEquals(other.actions, actions) &&
        listEquals(other.offers, offers);
  }

  @override
  int get hashCode {
    return item_Id.hashCode ^
        purcheOrder_Id.hashCode ^
        quantity.hashCode ^
        Unit.hashCode ^
        item.hashCode ^
        note.hashCode ^
        receiver.hashCode ^
        lastPrice.hashCode ^
        actions.hashCode ^
        offers.hashCode;
  }
}

class PurcheItemOffers {
  int PurcheItemOffers_Id;
  int item_Id;
  int purcheOrder_Id;
  String syplyer;
  double price;
  final List<ActionModel> actions;
  PurcheItemOffers({
    required this.PurcheItemOffers_Id,
    required this.item_Id,
    required this.purcheOrder_Id,
    required this.syplyer,
    required this.price,
    required this.actions,
  });

  PurcheItemOffers copyWith({
    int? PurcheItemOffers_Id,
    int? item_Id,
    int? purcheOrder_Id,
    String? syplyer,
    double? price,
    List<ActionModel>? actions,
  }) {
    return PurcheItemOffers(
      PurcheItemOffers_Id: PurcheItemOffers_Id ?? this.PurcheItemOffers_Id,
      item_Id: item_Id ?? this.item_Id,
      purcheOrder_Id: purcheOrder_Id ?? this.purcheOrder_Id,
      syplyer: syplyer ?? this.syplyer,
      price: price ?? this.price,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'PurcheItemOffers_Id': PurcheItemOffers_Id,
      'item_Id': item_Id,
      'purcheOrder_Id': purcheOrder_Id,
      'syplyer': syplyer,
      'price': price,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory PurcheItemOffers.fromMap(Map<String, dynamic> map) {
    return PurcheItemOffers(
      PurcheItemOffers_Id: map['PurcheItemOffers_Id'] as int,
      item_Id: map['item_Id'] as int,
      purcheOrder_Id: map['purcheOrder_Id'] as int,
      syplyer: map['syplyer'] as String,
      price: map['price'] as double,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PurcheItemOffers.fromJson(String source) =>
      PurcheItemOffers.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PurcheItemOffers(PurcheItemOffers_Id: $PurcheItemOffers_Id, item_Id: $item_Id, purcheOrder_Id: $purcheOrder_Id, syplyer: $syplyer, price: $price, actions: $actions)';
  }

  @override
  bool operator ==(covariant PurcheItemOffers other) {
    if (identical(this, other)) return true;

    return other.PurcheItemOffers_Id == PurcheItemOffers_Id &&
        other.item_Id == item_Id &&
        other.purcheOrder_Id == purcheOrder_Id &&
        other.syplyer == syplyer &&
        other.price == price &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return PurcheItemOffers_Id.hashCode ^
        item_Id.hashCode ^
        purcheOrder_Id.hashCode ^
        syplyer.hashCode ^
        price.hashCode ^
        actions.hashCode;
  }
}

class PurcheOrder {
  final int Id;
  final int serial;
  final String Adminstrationrequested;
  final DateTime dueDate;
  final String fl;
  final List<dynamic> financeManagerSingiture;

  final String gl;
  final List<dynamic> generalManagerSigniture;
  final String requester;
  final List<ActionModel> actions;
  final List<PurcheItem> items;
  final String status;
  PurcheOrder({
    required this.Id,
    required this.serial,
    required this.Adminstrationrequested,
    required this.dueDate,
    required this.fl,
    required this.financeManagerSingiture,
    required this.gl,
    required this.generalManagerSigniture,
    required this.requester,
    required this.actions,
    required this.items,
    required this.status,
  });

  PurcheOrder copyWith({
    int? Id,
    int? serial,
    String? Adminstrationrequested,
    DateTime? dueDate,
    String? fl,
    List<dynamic>? financeManagerSingiture,
    String? gl,
    List<dynamic>? generalManagerSigniture,
    String? requester,
    List<ActionModel>? actions,
    List<PurcheItem>? items,
    String? status,
  }) {
    return PurcheOrder(
      Id: Id ?? this.Id,
      serial: serial ?? this.serial,
      Adminstrationrequested:
          Adminstrationrequested ?? this.Adminstrationrequested,
      dueDate: dueDate ?? this.dueDate,
      fl: fl ?? this.fl,
      financeManagerSingiture:
          financeManagerSingiture ?? this.financeManagerSingiture,
      gl: gl ?? this.gl,
      generalManagerSigniture:
          generalManagerSigniture ?? this.generalManagerSigniture,
      requester: requester ?? this.requester,
      actions: actions ?? this.actions,
      items: items ?? this.items,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'serial': serial,
      'Adminstrationrequested': Adminstrationrequested,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'fl': fl,
      'financeManagerSingiture': financeManagerSingiture,
      'gl': gl,
      'generalManagerSigniture': generalManagerSigniture,
      'requester': requester,
      'actions': actions.map((x) => x.toMap()).toList(),
      'items': items.map((x) => x.toMap()).toList(),
      'status': status,
    };
  }

  factory PurcheOrder.fromMap(Map<String, dynamic> map) {
    return PurcheOrder(
      Id: map['Id'] as int,
      serial: map['serial'] as int,
      Adminstrationrequested: map['Adminstrationrequested'] as String,
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int),
      fl: map['fl'] as String,
      financeManagerSingiture:
          List<dynamic>.from((map['financeManagerSingiture'] as List<dynamic>)),
      gl: map['gl'] as String,
      generalManagerSigniture:
          List<dynamic>.from((map['generalManagerSigniture'] as List<dynamic>)),
      requester: map['requester'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      items: List<PurcheItem>.from(
        (map['items'] as List<dynamic>).map<PurcheItem>(
          (x) => PurcheItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PurcheOrder.fromJson(String source) =>
      PurcheOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PurcheOrder(Id: $Id, serial: $serial, Adminstrationrequested: $Adminstrationrequested, dueDate: $dueDate, fl: $fl, financeManagerSingiture: $financeManagerSingiture, gl: $gl, generalManagerSigniture: $generalManagerSigniture, requester: $requester, actions: $actions, items: $items, status: $status)';
  }

  @override
  bool operator ==(covariant PurcheOrder other) {
    if (identical(this, other)) return true;

    return other.Id == Id &&
        other.serial == serial &&
        other.Adminstrationrequested == Adminstrationrequested &&
        other.dueDate == dueDate &&
        other.fl == fl &&
        listEquals(other.financeManagerSingiture, financeManagerSingiture) &&
        other.gl == gl &&
        listEquals(other.generalManagerSigniture, generalManagerSigniture) &&
        other.requester == requester &&
        listEquals(other.actions, actions) &&
        listEquals(other.items, items) &&
        other.status == status;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        serial.hashCode ^
        Adminstrationrequested.hashCode ^
        dueDate.hashCode ^
        fl.hashCode ^
        financeManagerSingiture.hashCode ^
        gl.hashCode ^
        generalManagerSigniture.hashCode ^
        requester.hashCode ^
        actions.hashCode ^
        items.hashCode ^
        status.hashCode;
  }
}
