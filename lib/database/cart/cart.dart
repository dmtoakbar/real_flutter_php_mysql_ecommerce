import 'dart:core';

import 'package:ecom/database/cart/model.dart';
import 'package:ecom/database/database_configuration.dart';
import 'package:ecom/share/route/route_names.dart';
import 'package:ecom/share/route/routes.dart';
import 'package:ecom/share/widgets/snackbar/snackbar.dart';

import '../../share/global_variable/global_variable.dart';

class CartDatabase {
  static final context = NavigationService.navigatorKey.currentContext!;

  static redirect({required String routeName}) {
    CustomRoute.replace(context, routeName);
  }

  static final createTable = """
      CREATE TABLE IF NOT EXISTS cart(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      itemId INTEGER,
      cat TEXT,
      name TEXT,
      price TEXT,
      description TEXT,
      img TEXT,
      amount INTEGER
      )
      """;

  static Future<void> insertItem(
      {
        required int itemId,
        required String cat,
        required String name,
        required String price,
        required String description,
        required String img,
        required int amount,
      }
      ) async {
    final db = await ConfigDatabase.connect();
    db.execute(createTable);
    final data = {'itemId':itemId, 'cat':cat, 'name':name, 'price':price, 'description':description, 'img':img, 'amount':amount};
    final status = await db.insert('cart', data);
    if(status != null) {
      CustomSnackbar.successSnackbar(message: "Item added successfully to the cart");

    } else {
      CustomSnackbar.errorSnackbar(message: 'Something went wrong, please try again..');
    }

  }

  static Future<List<CartModel>> getItem() async {
    final db = await ConfigDatabase.connect();
    db.execute(createTable);
    final data = await db.query('cart', orderBy: 'id DESC');
    return data.map((e) => CartModel.fromJson(e)).toList();
  }

  static deleteCartItem({required int id}) async {
    final db = await ConfigDatabase.connect();
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
    redirect(routeName: TRouteNames.cartPage);
  }


}
