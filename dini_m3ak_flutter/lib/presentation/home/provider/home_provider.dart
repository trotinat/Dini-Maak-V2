import 'package:dini_maak/data/models/trip/trip_model.dart';
import 'package:dini_maak/data/models/user/user_model.dart';
import 'package:dini_maak/data/remote/trip_servoice.dart';
import 'package:dini_maak/data/remote/user_service.dart';
import 'package:dini_maak/di/locator.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  UserModel? user;
  List<TripMode> trips = [];
  final _userService = locator.get<UserService>();
  final _tripService = locator.get<TripService>();
  int selectedToggleIndex = 0;

  getUser() async {
    user = await _userService.getLoggedInUserInformation();
    notifyListeners();
  }

  getJoinedTrip() async {
    if (trips.isNotEmpty) trips.clear();

    trips = await _tripService.getJoinedTrip();
    notifyListeners();
  }

  getMyTrips() async {
    if (trips.isNotEmpty) trips.clear();

    trips = await _tripService.getMyTrip();
    notifyListeners();
  }
}
