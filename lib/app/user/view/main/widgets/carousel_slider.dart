import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/app/admin/controller/amin_slider_controller.dart';
import 'package:ecom/share/constants/api_constant.dart';
import 'package:ecom/share/constants/colors.dart';
import 'package:ecom/share/constants/image_string.dart';
import 'package:ecom/share/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({super.key});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _indicator = 0;
  CarouselSliderController carouselSliderController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AdminSliderController.getSlider(),
      builder:(context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          var dataSlider = snapshot.data;
          var dataFilter = [];
          for(int pi = dataSlider.length-1; pi > -1; pi--) {
            dataFilter.add(dataSlider[pi]);
          }
          var carouselLength = dataFilter.length >= 7 ? 7 : dataFilter.length;
          if(dataSlider.length > 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CarouselSlider.builder(
                  itemCount: carouselLength,
                  options: CarouselOptions(
                    height: 150,
                    aspectRatio: 16/9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _indicator = index;
                      });
                    },
                    scrollDirection: Axis.horizontal,

                  ),
                  itemBuilder: (context, index, pageView) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 280,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image(
                            image: NetworkImage(ApiEndPoints.baseURL+ApiEndPoints.sliderImage+dataFilter[index].img),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for(var i = 0; i < carouselLength; i++)...[
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                              color: _indicator == i ? TColors.primary : TColors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.black,
                                  width: 2
                              )
                          ),
                        ),
                      )
                    ]
                  ],
                )
              ],
            );
          } else {
            return const Center(
              child: Text('No Slider'),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}
