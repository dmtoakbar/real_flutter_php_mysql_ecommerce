import 'package:ecom/app/admin/controller/product_controller.dart';
import 'package:ecom/app/admin/products/product_edit.dart';
import 'package:ecom/share/route/route_names.dart';
import 'package:ecom/share/route/routes.dart';
import 'package:ecom/share/widgets/dialog/delete_dialog.dart';
import 'package:flutter/material.dart';

import '../../../share/constants/api_constant.dart';
import '../../../share/constants/colors.dart';
import '../../../share/constants/sizes.dart';

class ProductAdminPage extends StatelessWidget {
  const ProductAdminPage({super.key});

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace/2),
          child: Column(
            children: [
              const SizedBox(height: TSizes.defaultSpace/2,),
              Container(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        visualDensity: const VisualDensity(horizontal: 1, vertical: 0.2)
                    ),
                    onPressed: () {
                    CustomRoute.launch(context, TRouteNames.adminProductAddPage);
                    },
                    child: const Text('Add'),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems,),
              FutureBuilder(
                  future: AdminProductController.getProduct(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData) {
                      final data = snapshot.data;
                      return ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const ScrollPhysics(),
                          separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems,),
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 110,
                              decoration: BoxDecoration(
                                color: TColors.grey,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: 30,
                                            height: 30,
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.orange
                                            ),
                                            child: Center(child: Text('${index+1}.', style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),))
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Text('${data[index].name}', maxLines: 1, softWrap: true,),
                                        ),
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image(image: NetworkImage(
                                              ApiEndPoints.baseURL+ApiEndPoints.productImage+data[index].img,
                                            ),)
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Price: ${data[index].price}   '),
                                        Flexible(child: Text(data[index].description, maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: true,))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductEditPage(
                                               id: data[index].id, cat: data[index].cat, name: data[index].name, price: data[index].price, description: data[index].description
                                           )
                                           )
                                           );
                                          },
                                          child: Container(
                                              width: 50,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: const Center(child: Text('Edit', style: TextStyle(color: Colors.white),))
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                          TDeleteDialog.customDeleteDialog(
                                              onPressed: () {
                                               AdminProductController.deleteProduct(id: data[index].id);
                                              }
                                          );
                                          },
                                          child: Container(
                                              width: 70,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: const Center(child: Text('Delete', style: TextStyle(color: Colors.white),))
                                          ),
                                        ),
                                      ],
                                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}

