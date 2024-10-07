import 'package:ecom/app/admin/controller/cotegory_admin_controller.dart';
import 'package:ecom/share/constants/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../database/cart/cart.dart';
import '../../../../../database/cart/model.dart';
import '../../../../../share/constants/colors.dart';
import '../../../../../share/constants/sizes.dart';
import '../../../../../share/constants/text_string.dart';
import 'curved_edges.dart';

class TopHeadHomeScreen extends StatefulWidget {
  const TopHeadHomeScreen({
    super.key,
  });

  @override
  State<TopHeadHomeScreen> createState() => _TopHeadHomeScreenState();
}

class _TopHeadHomeScreenState extends State<TopHeadHomeScreen> {

 late List<CartModel> cartItem = <CartModel>[];
  final cart = CartDatabase.getItem();

  void noFuture() async {
    cartItem = await cart;
    setState(() {

    });
  }
  @override
  void initState() {
    noFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdge(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 350,
        color: Colors.red,
        padding: const EdgeInsets.all(TSizes.defaultSpace/2),
        child: Column(
          children: [
            // app bar
            SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(TText.appName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white), ),
                        Text('Vipal kumar', style: Theme.of(context).textTheme.bodySmall!.apply(color: Colors.white),)
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Icon(Iconsax.notification, color: Colors.white,),
                            Container(
                              width: 16,
                              height: 16,
                              transform: Matrix4.translationValues(-8, -8, 0),
                              decoration: const BoxDecoration(
                                  color: TColors.grey,
                                  shape: BoxShape.circle
                              ),
                              child: const Text('4', style: TextStyle(fontSize: 10), textAlign: TextAlign.center, softWrap: true,),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems /2,),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Icon(Iconsax.shopping_cart, color: Colors.white,),
                            Container(
                              width: 16,
                              height: 16,
                              transform: Matrix4.translationValues(-4, -8, 0),
                              decoration: const BoxDecoration(
                                  color: TColors.grey,
                                  shape: BoxShape.circle
                              ),
                              child: Text('${cartItem.length}', style: TextStyle(fontSize: 10), textAlign: TextAlign.center, softWrap: true,),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // end app bar
            const SizedBox(height: TSizes.spaceBtwSections,),
            // search
            SizedBox(
              width: 280,
              height: 50,
              child: TextField(

                style: const TextStyle(
                    color: Colors.grey
                ),
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    hintText: "Search . . .",
                    hintStyle: const TextStyle(
                        color: Colors.grey
                    ),

                    prefixIcon: const Icon(Iconsax.search_normal),
                    suffixIcon: const Icon(Iconsax.send_1),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)

                    ),
                    disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
              ),
            ),
            // end search
            // category
            const SizedBox(height: TSizes.spaceBtwSections,),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text('Popular Categories', style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white), textAlign: TextAlign.start,)
            ),

            const SizedBox(height: TSizes.spaceBtwItems/2,),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: CategoryAdminController.getCategory(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData) {
                      var dataCat = snapshot.data;
                      var dataFilter = [];
                      for(int pi = dataCat.length-1; pi > -1; pi--) {
                        dataFilter.add(dataCat[pi]);
                      }

                      return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: dataFilter.length >= 9 ? 9 : dataFilter.length,
                          separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems,),
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        image: DecorationImage(image: NetworkImage(ApiEndPoints.baseURL+ApiEndPoints.categoryImage+dataFilter[index].img),  fit: BoxFit.cover, )
                                    ),
                                  ),
                                  // CircleAvatar(
                                  //     radius: 30,
                                  //     foregroundImage: AssetImage(TImages.requestFailed)
                                  // ),
                                  SizedBox(
                                      width: 60,
                                      child: Text(dataFilter[index].name, style: Theme.of(context).textTheme.bodySmall!.apply(color: Colors.white), softWrap: true, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,)
                                  )
                                ],
                              ),
                            );
                          }
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }
                ),
              ),
            )
            // end category

          ],
        ),
      ),
    );
  }
}