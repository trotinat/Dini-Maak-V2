import 'dart:convert';

import 'package:dini_maak/data/models/car/car_model.dart';
import 'package:dini_maak/main.dart';
import 'package:dini_maak/shared/constants/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CarService {
  getAllCars() async {
    List<CarModel> cars = [];
    var response = await http.get(Uri.parse("${baseUrl}Car"), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);

      for (var json in jsonList) {
        cars.add(CarModel.fromJson(json));
      }
    }

    return cars;
  }

  Future<CarModel?> addNewCar({
    required String carName,
    required String carModel,
    required int maxSeatNumber,
  }) async {
    var response = await http.post(Uri.parse("${baseUrl}Car"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: jsonEncode({
          "carName": carName,
          "carModel": carModel,
          "maxSeatNumber": maxSeatNumber
        }));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("Car added");
      }
      return CarModel.fromJson(jsonDecode(response.body));
    }

    return null;
  }

  Future<bool> deleteCar({required String carId}) async {
    var res = await http.delete(Uri.parse("${baseUrl}Car/$carId"), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    if (res.statusCode == 200) return true;

    return false;
  }
}
