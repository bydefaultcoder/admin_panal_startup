class Unit {
  String? sId;
  late String name;
  int? intoBase;
  String? baseUnit;
  String? type;
  String? symbol;
  bool? isActive;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Unit(
      {this.sId,
      required this.name,
      this.intoBase,
      this.baseUnit,
      this.type,
      this.symbol,
      this.isActive,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Unit.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    intoBase = json['into_base'];
    baseUnit = json['base_unit'];
    type = json['type'];
    symbol = json['symbol'];
    isActive = json['is_active'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['into_base'] = this.intoBase;
    data['base_unit'] = this.baseUnit;
    data['type'] = this.type;
    data['symbol'] = this.symbol;
    data['is_active'] = this.isActive;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}