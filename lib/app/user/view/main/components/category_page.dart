import 'package:ecom/share/constants/colors.dart';
import 'package:ecom/share/constants/image_string.dart';
import 'package:ecom/share/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category List', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace/2),
        child: Column(
          children: [
            const SizedBox(height: TSizes.md,),
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.search_normal),
                hintText: 'Search Category . . .',
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Flexible(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 20,
                separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems,),
                itemBuilder: (_, __) {
                  return  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 280,
                      height: 60,
                      decoration: const BoxDecoration(
                          color: TColors.grey,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)
                          )
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)
                            ),
                            child: Image(
                              image: AssetImage(
                                  TImages.banner
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                          const Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(right: 3, left: 1),
                              child: Text(
                                'Cricket, Mecury, mango, worki, bitter , kumar ganj',
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
