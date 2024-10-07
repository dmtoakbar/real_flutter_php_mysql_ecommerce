

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../share/constants/sizes.dart';
import '../widgets/vertical_product_card.dart';

class ShopListItem extends StatelessWidget {
  const ShopListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Products', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
        body: Container(
           margin: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace/2, vertical: TSizes.defaultSpace),
          child: GridView.builder(
              itemCount:20,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: TSizes.gridViewSpacing,
                  crossAxisSpacing: TSizes.gridViewSpacing,
                  mainAxisExtent: 202.6
              ),
              itemBuilder: (_, __) {
                return VerticalProductCard();
              }
          ),
        ),
    );
  }
}
