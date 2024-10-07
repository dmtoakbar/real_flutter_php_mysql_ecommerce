import 'package:ecom/share/constants/colors.dart';
import 'package:ecom/share/constants/image_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import '../../../../../share/constants/sizes.dart';
import 'components/rating_reviews_progress_bar.dart';

class ProductRatingReviews extends StatelessWidget {
  const ProductRatingReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews & Rating', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: TSizes.spaceBtwItems,),
              const Text('Rating and Reviews are verified and are from people who use the same type of device that you use', textAlign: TextAlign.center,),
              const SizedBox(height: TSizes.spaceBtwItems,),
               Row(
                 children: [
                   Expanded(
                      flex: 3,
                       child: Text('4.8', style: Theme.of(context).textTheme.displayLarge,)
                   ),
                   const Expanded(
                      flex: 7,
                       child: Column(
                         children: [
                           RatingReviewProgressBar(text: '5', value: 1,),
                           RatingReviewProgressBar(text: '4', value: .8,),
                           RatingReviewProgressBar(text: '3', value: .6,),
                           RatingReviewProgressBar(text: '2', value: .2,),
                           RatingReviewProgressBar(text: '1', value: .1,)
                         ],
                       )
                   )
                 ],
               ),
              RatingBarIndicator(
                rating: 3.5,
                itemCount: 5,
                itemSize: 20,
                direction: Axis.horizontal,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.blue,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: Text('2349', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),),
              ),
              const SizedBox(height: TSizes.spaceBtwSections,),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              backgroundImage: AssetImage(TImages.banner)
                          ),
                          const SizedBox(width: 10,),
                          Text('Amit kumar', style: Theme.of(context).textTheme.bodyLarge,)
                        ],
                      ),
                      const Icon(Icons.more_vert)
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems/2,),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: 3.5,
                        itemCount: 5,
                        itemSize: 15,
                        direction: Axis.horizontal,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      const Text('05 Nov, 2024', style: TextStyle(color: TColors.darkerGrey, fontSize: 12),)
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems/2,),
                  const ReadMoreText(
                    'One of the most effective ways to check if a profile picture is fake by conductions or One of the most effective ways to check if a profile picture is fake by conductions or One of the most effective ways to check if a profile picture is fake by conductions or ',
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue),
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(TSizes.defaultSpace/2),
                    decoration: BoxDecoration(
                        color: TColors.grey,
                        borderRadius: BorderRadius.circular(7)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Amit kumar', style: Theme.of(context).textTheme.bodyLarge,),
                            const Text('07 Nov, 2024', style: TextStyle(color: TColors.darkerGrey, fontWeight: FontWeight.w500, fontSize: 12),)
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems/2,),
                        const ReadMoreText(
                          'One of the most effective ways to check if a profile picture is fake by conductions or One of the most effective ways to check if a profile picture is fake by conductions or One of the most effective ways to check if a profile picture is fake by conductions or ',
                          trimMode: TrimMode.Line,
                          trimLines: 2,
                          colorClickableText: Colors.pink,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue),
                          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

