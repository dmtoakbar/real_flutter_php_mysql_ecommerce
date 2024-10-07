import 'package:ecom/share/constants/colors.dart';
import 'package:ecom/share/constants/sizes.dart';
import 'package:ecom/share/route/route_names.dart';
import 'package:ecom/share/route/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ShopListPage extends StatelessWidget {
  const ShopListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace/2),
            child: SafeArea(child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Shop List', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white),),
            )),
          ),
          Flexible(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace/2, vertical: TSizes.defaultSpace/2),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purple, Colors.orange],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15)
                          )
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Shop Name', style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                const Icon(Iconsax.shop, color: Colors.white,)
                              ],
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems/2,),
                          GestureDetector(
                            onTap: () {
                              CustomRoute.launch(context, TRouteNames.shopProduct);
                            },
                            child: Container(
                              width: 150,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: Color(0xFF0CB29E),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)
                                  )
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('View Products', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                                  Icon(Iconsax.arrow_right_4, color: Colors.white,)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              )
          )
        ],
      ),
    );
  }
}
