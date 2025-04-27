class Unit {
  late String name;
  late int intoBase;
  String? baseUnit;
  late String type;
  late String symbol;
  bool? isActive;
  String? description;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Unit(
      {required this.name,
      required this.intoBase,
      this.baseUnit,
      required this.type,
      required this.symbol,
      this.isActive,
      this.description,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Unit.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    intoBase = json['into_base'];
    baseUnit = json['base_unit'];
    type = json['type'];
    symbol = json['symbol'];
    isActive = json['is_active'];
    description = json['description'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['into_base'] = this.intoBase;
    data['base_unit'] = this.baseUnit;
    data['type'] = this.type;
    data['symbol'] = this.symbol;
    data['is_active'] = this.isActive;
    data['description'] = this.description;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}