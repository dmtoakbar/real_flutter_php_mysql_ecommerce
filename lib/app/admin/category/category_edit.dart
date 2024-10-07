import 'package:ecom/app/admin/controller/cotegory_admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../share/constants/colors.dart';
import '../../../share/constants/sizes.dart';

class CategoryEditPage extends StatefulWidget {
  CategoryEditPage({super.key, required this.catName, required this.id});
  String catName;
  String id;

  @override
  State<CategoryEditPage> createState() => _CategoryEditPageState();
}

class _CategoryEditPageState extends State<CategoryEditPage> {

  XFile? image;
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    TextEditingController name = TextEditingController(text: widget.catName);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Category', style: TextStyle(color: Colors.white),),
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
                      TextFormField(
                        autovalidateMode: AutovalidateMode.disabled,
                        keyboardType: TextInputType.text,
                        controller: name,
                        decoration: const InputDecoration(
                            hintText: 'Enter category name',
                            labelText: 'Category *',
                            prefixIcon: Icon(Iconsax.category)
                        ),
                        validator: (String? value) {
                          if(value!.isEmpty) {
                            return 'Category name required..';
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
                       CategoryAdminController.editCategory(image: image, name: name.text, id: widget.id);
                    }
                  },
                  child: const Text('Update'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



