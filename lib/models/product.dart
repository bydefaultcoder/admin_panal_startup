class Product {
  String? sId;
  String? description;
  double? sellingPrice;
  double? offerSellingPrice;
  ProRef? proCategoryId;
  String? name;
  ProRef? unitId;
  ProRef? proSubCategoryId;
  ProRef? proBrandId;
  ProTypeRef? proVariantTypeId;
  List<String>? proVariantId;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Product(
      {this.sId,
        this.name,
        this.description,
        this.sellingPrice,
        this.offerSellingPrice,
        this.proCategoryId,
        this.proSubCategoryId,
        this.proBrandId,
        this.unitId,
        this.proVariantTypeId,
        this.proVariantId,
        this.images,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    sellingPrice = json['sellingPrice']?.toDouble();
    offerSellingPrice = json['offerSellingPrice']?.toDouble();
    proCategoryId = json['category'] != null
        ? new ProRef.fromJson(json['category'])
        : null;
    proSubCategoryId = json['subCategory'] != null
        ? new ProRef.fromJson(json['subCategory'])
        : null;
    proBrandId = json['brand'] != null
        ? new ProRef.fromJson(json['brand'])
        : null;
    unitId = json['unit'] != null
        ? new ProRef.fromJson(json['unit'])
        : null;
    print(json['variantType']);
    proVariantTypeId = json['variantType'] != null
        ? new ProTypeRef.fromJson(json['variantType'])
        : null;
    proVariantId = json['variant'].cast<String>();
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.sellingPrice;
    data['offerSellingPrice'] = this.offerSellingPrice;
    if (this.proCategoryId != null) {
      data['category'] = this.proCategoryId!.toJson();
    }
    if (this.proBrandId != null) {
      data['brand'] = this.proBrandId!.toJson();
    }
    if (this.proSubCategoryId != null) {
      data['subCategory'] = this.proSubCategoryId!.toJson();
    }
    if (this.unitId != null) {
      data['unit'] = this.unitId!.toJson();
    }
    if (this.proVariantTypeId != null) {
      data['variantType'] = this.proVariantTypeId!.toJson();
    }
    data['variant'] = this.proVariantId;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ProRef {
  String? sId;
  String? name;

  ProRef({this.sId, this.name});

  ProRef.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class ProTypeRef {
  String? sId;
  String? type;

  ProTypeRef({this.sId, this.type});

  ProTypeRef.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['type'] = this.type;
    return data;
  }
}

class Images {
  int? image;
  String? url;
  String? sId;

  Images({this.image, this.url, this.sId});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    url = json['url'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['url'] = this.url;
    data['_id'] = this.sId;
    return data;
  }
}