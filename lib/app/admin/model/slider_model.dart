import 'dart:convert';

List<SliderModel> sliderModelFromJson(String str) =>
    List<SliderModel>.from(json.decode(str).map((x) => SliderModel.fromJson(x)));

class SliderModel {
  String? id;
  String? cat;
  String? img;
  SliderModel({this.id, this.cat, this.img});

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cat = json['cat'];
    img = json['img'];
  }

}