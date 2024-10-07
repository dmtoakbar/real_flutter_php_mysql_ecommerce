import 'package:ecom/app/admin/controller/cotegory_admin_controller.dart';
import 'package:ecom/app/admin/controller/product_controller.dart';
import 'package:ecom/app/admin/model/product_model.dart';
import 'package:ecom/app/user/view/main/widgets/vertical_product_card.dart';
import 'package:ecom/share/constants/api_constant.dart';
import 'package:ecom/share/constants/image_string.dart';
import 'package:ecom/share/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/widgets.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin<CustomTabBar> {
  late var tabLength;
  late TabController tabController =
      TabController(length: tabLength, vsync: this);
  final productController = AdminProductController.getProduct();

  var productList = [];

  productListFunction() async {
    productList = await productController;
  }

  Map<String, dynamic> productAccordCatMap = {};

  Widget  productAccordingCategoryFunction({required String category}) {
    var listProduct = productList.where((element) => element.cat.contains(category)).toList();
    productAccordCatMap[category] = listProduct;
    return const SizedBox();
  }

  @override
  void initState() {
    productListFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CategoryAdminController.getCategory(),
      builder: (context, AsyncSnapshot snapshot) {
        var catProduct = [];
        var productLength = [];
        if (snapshot.hasData) {
          var dataRaw = snapshot.data;
          var catFilter = [];
          for (int i = dataRaw.length - 1; i > -1; i--) {
            catFilter.add(dataRaw[i]);
          }
          var tabCondition = dataRaw.length >= 7 ? 7 : dataRaw.length;
          tabLength = dataRaw.length >= 7 ? 7 + 1 : dataRaw.length + 1;

          // add category in catProduct
          for (int catProductCount = 0;
              catProductCount < tabCondition;
              catProductCount++) {
            catProduct.add(dataRaw[catProductCount].name);
          }

          for (int productLengthCount = 0;
              productLengthCount < tabCondition;
              productLengthCount++) {
            int length = 0;
            for (int product = 0; product < productList.length; product++) {
              if (productList[product].cat == catProduct[productLengthCount]) {
                length++;
              }
            }
            productLength.add(length);
          }

          if (dataRaw.length > 0) {
            return Column(
              children: [
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  controller: tabController,
                  tabs: [
                    const Tab(
                      text: 'Trending',
                    ),
                    for (int tabCount = 0;
                        tabCount < tabCondition;
                        tabCount++) ...[
                      Tab(
                          text: dataRaw[tabCount]
                                  .name[0]
                                  .toString()
                                  .toUpperCase() +
                              dataRaw[tabCount].name.toString().substring(1)),
                    ]
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Container(
                  padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
                  child:
                      AutoScaleTabBarView(controller: tabController, children: [
                    // trending
                    Column(
                      children: [
                        SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: tabCondition,
                            separatorBuilder: (_, __) => const SizedBox(
                              width: TSizes.spaceBtwItems,
                            ),
                            itemBuilder: (_, index) {
                              return Card(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Image(
                                          image: NetworkImage(
                                              ApiEndPoints.baseURL +
                                                  ApiEndPoints.categoryImage +
                                                  catFilter[index].img),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 1),
                                        alignment: Alignment.centerRight,
                                        width: 110,
                                        height: 60,
                                        child: Text(
                                          catFilter[index]
                                                  .name[0]
                                                  .toString()
                                                  .toUpperCase() +
                                              catFilter[index]
                                                  .name
                                                  .toString()
                                                  .substring(1),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Recommended',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                  textAlign: TextAlign.start,
                                )),
                            const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            GridView.builder(
                                itemCount: productList.isNotEmpty
                                    ? productList.length
                                    : 1,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                physics: const ScrollPhysics(),
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: TSizes.gridViewSpacing,
                                    crossAxisSpacing: TSizes.gridViewSpacing,
                                    mainAxisExtent:
                                    productList.isNotEmpty
                                        ? 202.6
                                        : MediaQuery.of(context)
                                        .size
                                        .width),
                                itemBuilder: (_, index) {
                                  if (productList.isNotEmpty) {
                                    return VerticalProductCard(data: [productList[index]],);
                                  } else {
                                    return const Text(
                                      'No items found..',
                                      textAlign: TextAlign.center,
                                      style:
                                      TextStyle(fontWeight: FontWeight.w500),
                                    );
                                  }
                                }),
                          ],
                        )
                      ],
                    ),
                    for (int tabBarCount = 0;
                        tabBarCount < tabCondition;
                        tabBarCount++) ...[
                      Column(
                        children: [
                          if(4 < 5)...{
                            productAccordingCategoryFunction(category: catProduct[tabBarCount])
                          },
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Recommended',
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.start,
                              )),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          GridView.builder(
                              itemCount: productLength[tabBarCount] > 0
                                  ? productLength[tabBarCount]
                                  : 1,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: TSizes.gridViewSpacing,
                                      crossAxisSpacing: TSizes.gridViewSpacing,
                                      mainAxisExtent:
                                          productLength[tabBarCount] > 0
                                              ? 202.6
                                              : MediaQuery.of(context)
                                                  .size
                                                  .width),
                              itemBuilder: (_, index) {
                                if (productLength[tabBarCount] > 0) {
                                  return VerticalProductCard(data: [productAccordCatMap[catProduct[tabBarCount]][index]],);
                                } else {
                                  return const Text(
                                    'No items found..',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  );
                                }
                              }),
                        ],
                      )
                    ]
                  ]),
                )
              ],
            );
          } else {
            return const Center(
              child: Text('No record'),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
