import 'dart:convert';

import 'package:dini_maak/data/models/city/city_model.dart';
import 'package:dini_maak/data/models/trip/create_trip_model.dart';
import 'package:dini_maak/data/models/trip/trip_model.dart';
import 'package:dini_maak/main.dart';
import 'package:dini_maak/shared/constants/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TripService {
  Future<List<CityModel>> getCities() async {
    List<CityModel> cities = [];
    var response = await http.get(Uri.parse("${baseUrl}City"));
    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      for (var json in jsonList) {
        cities.add(CityModel.fromJson(json));
      }
    }
    return cities;
  }

  Future<List<TripMode>> getMyTrip() async {
    List<TripMode> trips = [];
    var res = await http.get(Uri.parse("${baseUrl}Trip/Owner"), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    if (res.statusCode == 200) {
      var jsonList = jsonDecode(res.body);
      for (var json in jsonList) {
        trips.add(TripMode.fromJson(json));
      }
    }
    return trips;
  }

  Future<List<TripMode>> getJoinedTrip() async {
    List<TripMode> trips = [];
    var res = await http.get(Uri.parse("${baseUrl}Trip/Joined"), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    if (res.statusCode == 200) {
      var jsonList = jsonDecode(res.body);
      for (var json in jsonList) {
        trips.add(TripMode.fromJson(json));
      }
    }
    return trips;
  }

  Future<List<TripMode>> getTrip(
      {required String fromCityName,
      required String toCityName,
      required String tripDate}) async {
    List<TripMode> trips = [];
    var res = await http.get(
        Uri.parse(
            "${baseUrl}Trip/query?fromCityName=$fromCityName&destinationCity=$toCityName&tripDate=$tripDate"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });

    if (kDebugMode) {
      print(res.body);
    }

    if (res.statusCode == 200) {
      var jsonList = jsonDecode(res.body);
      for (var json in jsonList) {
        trips.add(TripMode.fromJson(json));
      }
    }
    return trips;
  }

  Future<bool> createTrip({required CreateTripModel tripModel}) async {
    var response = await http.post(
      Uri.parse("${baseUrl}Trip"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
      body: jsonEncode(
        {
          "tripPrice": tripModel.tripPrice,
          "totalSeats": tripModel.totalSeats,
          "fromCityId": tripModel.fromCityId,
          "toCityId": tripModel.toCityId,
          "tripDate": tripModel.tripDate,
          "carId": tripModel.cardId
        },
      ),
    );

    return response.statusCode == 200;
  }

  Future<bool> bookTrip({required String tripId}) async {
    var res = await http.put(
      Uri.parse("${baseUrl}Trip/$tripId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
    );

    return res.statusCode == 200;
  }

  Future<bool> closeTrip({required String tripid}) async {
    var res = await http.put(
      Uri.parse("${baseUrl}Trip/$tripid"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
    );

    return res.statusCode == 200;
  }
}
