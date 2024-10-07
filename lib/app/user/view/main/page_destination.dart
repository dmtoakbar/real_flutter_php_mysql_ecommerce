import 'package:ecom/app/user/view/main/components/cart_page.dart';
import 'package:ecom/app/user/view/main/components/category_page.dart';
import 'package:ecom/app/user/view/main/components/home.dart';
import 'package:ecom/app/user/view/main/components/shop_list_page.dart';
import 'package:ecom/app/user/view/main/components/user_profile.dart';
import 'package:flutter/cupertino.dart';

class PageDestination {

  static final page = [
    const HomeScreen(),
    const ShopListPage(),
    const CategoryPage(),
    const CartPage(),
    const UserProfilePage()
  ];
}