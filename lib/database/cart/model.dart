class CartModel {
  int? id;
  int? itemId;
  String? cat;
  String? name;
  String? price;
  String? description;
  String? img;
  int? amount;
  CartModel({this.id, this.itemId, this.cat, this.name, this.price, this.description, this.img, this.amount});


  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['itemId'];
    cat = json['cat'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    img = json['img'];
    amount =  json['amount'];
  }


}