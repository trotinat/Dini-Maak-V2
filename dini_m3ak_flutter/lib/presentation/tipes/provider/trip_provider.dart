import 'package:dini_maak/data/models/city/city_model.dart';
import 'package:dini_maak/data/models/trip/create_trip_model.dart';
import 'package:dini_maak/data/models/trip/trip_model.dart';
import 'package:dini_maak/data/remote/trip_servoice.dart';
import 'package:dini_maak/di/locator.dart';
import 'package:flutter/material.dart';

class TripProvider extends ChangeNotifier {
  final _tripService = locator.get<TripService>();
  late TextEditingController tripPrice;
  late TextEditingController toatlSeats;
  TripMode? tripDetails;

  List<CityModel> cities = [];

  String selectedFromCity = "";
  String selectedDestinationCityName = "";
  DateTime? selectedDateTime;

  List<TripMode> myTrips = [];
  List<TripMode> queryTrip = [];
  bool isLoading = false;

  getMyTrips() async {
    myTrips = await _tripService.getMyTrip();
    notifyListeners();
  }

  getTrips() async {
    isLoading = true;
    queryTrip = await _tripService.getTrip(
      fromCityName: selectedFromCity,
      toCityName: selectedDestinationCityName,
      tripDate: selectedDateTime!.toUtc().toIso8601String(),
    );
    isLoading = false;
    notifyListeners();
  }

  getAllCites() async {
    cities = await _tripService.getCities();

    if (cities.isNotEmpty) {
      selectedFromCity = cities[0].cityName;
      selectedDestinationCityName = cities[0].cityName;
    }

    notifyListeners();
  }

  onFromCityChanged(String cityName) {
    selectedFromCity = cityName;
    notifyListeners();
  }

  onDestinationCityChanged(String destinationCity) {
    selectedDestinationCityName = destinationCity;
    notifyListeners();
  }

  createTrip({required String selectedCarId}) async {
    String fromCityId =
        cities.firstWhere((element) => element.cityName == selectedFromCity).id;
    String toCityId = cities
        .firstWhere(
            (element) => element.cityName == selectedDestinationCityName)
        .id;
    return await _tripService.createTrip(
      tripModel: CreateTripModel(
        tripPrice: int.parse(tripPrice.text),
        totalSeats: int.parse(toatlSeats.text),
        fromCityId: fromCityId,
        toCityId: toCityId,
        tripDate: selectedDateTime!.toUtc().toIso8601String(),
        cardId: selectedCarId,
      ),
    );
  }

  bookTrip({required TripMode tripMode}) async {
    var res = await _tripService.bookTrip(tripId: tripMode.id);
    return res;
  }

  closeTrip({required TripMode tripMode}) async {
    return _tripService.closeTrip(tripid: tripMode.id);
  }
}
