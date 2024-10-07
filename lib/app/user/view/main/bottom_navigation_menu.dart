import 'package:ecom/app/user/view/main/page_destination.dart';
import 'package:ecom/share/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavigationMenu extends StatefulWidget {
  const BottomNavigationMenu({super.key});

  @override
  State<BottomNavigationMenu> createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 0,
        backgroundColor: TColors.white,
        indicatorColor: TColors.grey,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex=index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
          NavigationDestination(icon: Icon(Iconsax.category), label: 'Category'),
          NavigationDestination(icon: Icon(Iconsax.shopping_bag), label: 'Shopping'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Admin'),
        ],
      ),
      body: PageDestination.page[_selectedIndex],
    );
  }
}
