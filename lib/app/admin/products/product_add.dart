import 'package:ecom/app/admin/controller/cotegory_admin_controller.dart';
import 'package:ecom/app/admin/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../share/constants/colors.dart';
import '../../../share/constants/sizes.dart';
import '../../../share/widgets/snackbar/snackbar.dart';

class AdminProductAddPage extends StatefulWidget {
  const AdminProductAddPage({super.key});

  @override
  State<AdminProductAddPage> createState() => _AdminProductAddPageState();
}

class _AdminProductAddPageState extends State<AdminProductAddPage> {
  String? selectedValue;
  XFile? image;
  final name = TextEditingController();
  final price = TextEditingController();
  final description = TextEditingController();
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product', style: TextStyle(color: Colors.white),),
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
              const SizedBox(height: TSizes.spaceBtwSections,),
              Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     FutureBuilder(
                         future: CategoryAdminController.getCategory(),
                         builder: (context, AsyncSnapshot snapshot) {
                           if(snapshot.hasData) {
                             final dataList = snapshot.data;
                             List<String> categoryList = [];
                             for(int i=0; i < dataList.length; i++) {
                                categoryList.add(dataList[i].name);
                             }
                             return  DropdownButtonFormField<String>(
                               value: selectedValue,
                               hint: const Text('Select a category'),
                               dropdownColor: Colors.transparent,
                               elevation: 0,
                               isExpanded: true,
                               decoration: const InputDecoration(
                                 prefixIcon: Icon(Iconsax.category),
                               ),
                               onChanged: (String? newValue) {
                                 setState(() {
                                   selectedValue = newValue;
                                 });
                               },
                               validator: (String? value) {
                                 if (value == null) {
                                   return 'Please select a category';
                                 }
                                 return null;
                               },
                               items: categoryList.map<DropdownMenuItem<String>>((String value) {
                                 return DropdownMenuItem<String>(
                                   value: value,
                                   child: Container(
                                     alignment: Alignment.center,
                                       height: 40,
                                       decoration: BoxDecoration(
                                         color: TColors.grey,
                                         borderRadius: BorderRadius.circular(15)
                                       ),
                                       child: Text(value)
                                   ),
                                 );
                               }).toList(),
                             );
                           } else {
                             return const CircularProgressIndicator();
                           }
                         }
                     ),
                      const SizedBox(height: TSizes.spaceBtwItems,),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.disabled,
                        keyboardType: TextInputType.text,
                        controller: name,
                        decoration: const InputDecoration(
                            hintText: 'Enter product name',
                            labelText: 'Product *',
                            prefixIcon: Icon(Iconsax.text),
                        ),
                        validator: (String? value) {
                          if(value!.isEmpty) {
                            return 'Product name required..';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems,),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.disabled,
                        keyboardType: TextInputType.number,
                        controller: price,
                        decoration: const InputDecoration(
                            hintText: 'Enter product price',
                            labelText: 'Price *',
                            prefixIcon: Icon(Icons.price_check),
                        ),
                        validator: (String? value) {
                          if(value!.isEmpty) {
                            return 'Product price required..';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems,),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.disabled,
                        keyboardType: TextInputType.multiline,
                        controller: description,
                        minLines: 6,
                        maxLines: 9,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                            hintText: 'Enter product description',
                            labelText: 'Description *',
                            isDense: true,
                            prefixIconConstraints: BoxConstraints(
                              maxHeight: 0,
                              maxWidth: 0
                            ),
                           alignLabelWithHint: true,
                        ),
                        validator: (String? value) {
                          if(value!.isEmpty) {
                            return 'Product description required..';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems,)
                    ],
                  )
              ),
              const SizedBox(
                width: 150,
                child: Text('Upload image *', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
              ),
              const SizedBox(height: 3,),
              GestureDetector(
                onTap: () async {
                  final getImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                  setState(() {
                    image = getImage;
                  });
                },
                child: Container(
                  height: 56,
                  width: 150,
                  decoration: BoxDecoration(
                      border: Border.all(color: TColors.darkerGrey.withOpacity(0.6), width: 1),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                      )
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9),
                        child: Icon(Iconsax.image, color: Colors.grey,),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9),
                        child: Icon(Icons.upload_rounded, color: Colors.grey,),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems,),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    if(formKey.currentState!.validate() == true) {
                      if(image != null) {
                         AdminProductController.addProduct(cat: selectedValue.toString(), name: name.text, price: price.text, description: description.text, image: image);
                      } else {
                        CustomSnackbar.errorSnackbar(message: 'Please select an image for product...');
                      }
                    }
                  },
                  child: const Text('Add'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
