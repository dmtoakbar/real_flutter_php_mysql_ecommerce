import 'package:ecom/app/user/view/main/essentials/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../share/constants/api_constant.dart';
import '../../../../../share/constants/colors.dart';
import '../../../../../share/constants/image_string.dart';
import '../../../../../share/constants/sizes.dart';
import '../../../../admin/model/product_model.dart';


class VerticalProductCard extends StatelessWidget {
  VerticalProductCard({
    super.key,
    this.data
  });
  List<ProductModel>? data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailPage(data: data!)));
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(
            color: TColors.light,
            borderRadius: BorderRadius.circular(TSizes.md)
        ),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 160,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(TSizes.md),
                        topRight: Radius.circular(TSizes.md)
                    ),
                    child: Image(
                      height: 80,
                      width: 160,
                      image: NetworkImage(ApiEndPoints.baseURL+ApiEndPoints.productImage+data![0].img!),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                    top: 9,
                    left: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.xs, vertical: TSizes.xs),
                      decoration: BoxDecoration(
                          color: TColors.secondary.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(TSizes.sm)
                      ),
                      child: Text(
                        '34%',
                        style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.black),
                      ),
                    )
                ),
                Positioned(
                    top: 3,
                    right: 3,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                          padding: const EdgeInsets.all(TSizes.xs),
                          decoration: const BoxDecoration(
                              color: TColors.white,
                              shape: BoxShape.circle
                          ),
                          child: const Icon(Iconsax.heart5)
                      ),
                    )
                )
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${data?[0].name}',
                    style: const TextStyle(
                        fontSize: 12
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Row(
                    children: [
                      Text(
                          'Nike',
                          style: TextStyle(
                              fontSize: 11
                          )
                      ),
                      SizedBox(width: TSizes.xs/2,),
                      Icon(Iconsax.verify5, color: TColors.primary, size: 10,)
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 6,
                      bottom: 1
                  ),
                  child: Text('\$${data?[0].price}', style: Theme.of(context).textTheme.headlineSmall),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: TColors.black,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(TSizes.md),
                            bottomRight: Radius.circular(TSizes.md)
                        )
                    ),
                    child: const Icon(Iconsax.add, color: TColors.white,),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}