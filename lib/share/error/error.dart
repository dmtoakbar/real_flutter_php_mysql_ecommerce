
import 'package:ecom/share/constants/image_string.dart';
import 'package:ecom/share/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, this.error, this.errorBuilder});

  final String? error;
  final (BuildContext, GoRouterState)? errorBuilder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nexus Shop'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Center(
            child: Column(
              children: [
                const Center(
                  child: Image(
                    image: AssetImage(TImages.requestFailed),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems,),
                Text('Sorry, an error encountered!', style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.black), textAlign: TextAlign.center,),
                const SizedBox(height: TSizes.spaceBtwItems,),
                Text(error ?? 'Error: 404\n\n Page doesn\'t exist!', style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.red), textAlign: TextAlign.center,),
                const SizedBox(height: TSizes.spaceBtwItems,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
