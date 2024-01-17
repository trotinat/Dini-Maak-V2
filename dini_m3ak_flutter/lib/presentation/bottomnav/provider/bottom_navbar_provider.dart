import 'package:dini_maak/data/remote/user_service.dart';
import 'package:dini_maak/di/locator.dart';
import 'package:dini_maak/presentation/cars/cars_page.dart';
import 'package:dini_maak/presentation/home/home_page.dart';
import 'package:dini_maak/presentation/tipes/trip_page.dart';
import 'package:dini_maak/presentation/wallet/wallet_page.dart';
import 'package:flutter/material.dart';

class BottomNavbarProvider extends ChangeNotifier {
  List<Widget> pages = const [HomePage(), TripPage(), CarsPage(), WalletPage()];

  int currentPageIndex = 0;

  final UserService _userService = locator.get<UserService>();

  void onPageChanged(int newIndex) {
    currentPageIndex = newIndex;
    notifyListeners();
  }

  getUserInfo() async {
    await _userService.getLoggedInUserInformation();
  }
}
