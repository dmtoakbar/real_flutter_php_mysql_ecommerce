import 'dart:convert';

import 'package:ecom/database/cart/cart.dart';
import 'package:ecom/database/cart/model.dart';
import 'package:ecom/share/constants/api_constant.dart';
import 'package:ecom/share/constants/colors.dart';
import 'package:ecom/share/constants/image_string.dart';
import 'package:ecom/share/constants/sizes.dart';
import 'package:ecom/share/widgets/snackbar/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace/2),
        child: FutureBuilder(
          future: CartDatabase.getItem(),
          builder: (context, AsyncSnapshot snapshot) {
            final data = snapshot.data;
            num grandTotal = 0;
            if(snapshot.hasData) {
              for(int t = 0; t < data.length; t++) {
                grandTotal = grandTotal + data[t].amount * int.parse(data[t].price);
              }
              return Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(15
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          Text('Item: ${data.length}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  for(int i = 0; i < data.length; i++)...[
                    GestureDetector(
                      onTap: () {
                      CartDatabase.deleteCartItem(id: data[i].id);
                      },
                      child: Container(
                          width: 25,
                          height: 25,
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.clear, color: Colors.white,)
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: TColors.grey,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('${data[i].name}', style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                            const SizedBox(height: TSizes.spaceBtwItems/2,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: 60,
                                      width: 150,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image(
                                            image: NetworkImage(ApiEndPoints.baseURL + ApiEndPoints.productImage + data[i].img)
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 34,
                                      width: 34,
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: Center(
                                        child: Text('${data[i].amount}'),
                                      ),
                                    ),
                                  ],
                                ),
                                Text('₹${data[i].amount * int.parse(data[i].price)}')
                              ],
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems/2,),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems/2,)
                  ],
                  const SizedBox(height: TSizes.spaceBtwItems/2,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('Grand Total:', style: Theme.of(context).textTheme.headlineSmall,),
                     Text('₹${grandTotal.toString()}', style: Theme.of(context).textTheme.headlineSmall,)
                   ],
                 ),
                  const SizedBox(height: TSizes.spaceBtwItems,),
                 SizedBox(
                   width: MediaQuery.of(context).size.width,
                   child: ElevatedButton(
                     onPressed: (){},
                     child: const Text('Check out'),
                   ),
                 ),
                  const SizedBox(height: TSizes.spaceBtwSections,),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator.adaptive(),);
            }
          },
        )
      ),
    );
  }
}
