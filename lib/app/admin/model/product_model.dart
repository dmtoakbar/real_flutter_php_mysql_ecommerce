import 'dart:convert';


List<ProductModel> productModelFromJson(String str) =>
    List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

class ProductModel {
  String? id;
  String? cat;
  String? name;
  String? price;
  String? description;
  String? img;

  ProductModel(
      {this.id, this.cat, this.name, this.price, this.description, this.img});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cat = json['cat'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cat'] = cat;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['img'] = img;
    return data;
  }
}
