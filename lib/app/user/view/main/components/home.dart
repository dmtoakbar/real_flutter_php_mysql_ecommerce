import 'package:ecom/app/user/view/main/widgets/carousel_home_screen.dart';
import 'package:ecom/app/user/view/main/widgets/custom_tab_bar.dart';
import 'package:ecom/app/user/view/main/widgets/top_head_home_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //-------------top head section -------------------//
            TopHeadHomeScreen(),
            //----------------------------------end top head section -------------------
           // body
            CarouselHomeScreen(),
            CustomTabBar()
            // end body
          ],
        ),

      ),
    );
  }
}




