import 'package:dini_maak/presentation/bottomnav/provider/bottom_navbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class NavigationPage extends StatefulWidget {
  static String navPage = "/navigation";

  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavbarProvider>(
      builder: (_, data, __) => Scaffold(
        body: data.pages[data.currentPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => data.onPageChanged(index),
          currentIndex: data.currentPageIndex,
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.activity,
              ),
              label: "Trips",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.car,
              ),
              label: "Cars",
            ),
          ],
        ),
      ),
    );
  }
}
