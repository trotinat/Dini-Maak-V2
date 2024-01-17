import 'package:dini_maak/data/models/car/car_model.dart';
import 'package:dini_maak/data/models/city/city_model.dart';
import 'package:dini_maak/data/models/user/user_model.dart';

class TripMode {
  final String id;
  final int tripPrice;
  final int totalSeats;
  final int remainingSeats;
  final CityModel fromCity;
  final CityModel toCity;
  final UserModel owner;
  final List<UserModel> passangers;
  final String status;
  final CarModel car;
  final String tripDate;

  TripMode(
      {required this.id,
      required this.tripPrice,
      required this.totalSeats,
      required this.remainingSeats,
      required this.fromCity,
      required this.toCity,
      required this.owner,
      required this.passangers,
      required this.status,
      required this.car,
      required this.tripDate});

  factory TripMode.fromJson(Map<String, dynamic> json) {
    return TripMode(
      id: json['id'],
      tripPrice: json['tripPrice'],
      totalSeats: json['totalSeats'],
      remainingSeats: json['remainingSeats'],
      fromCity: CityModel.fromJson(json['fromCity']),
      toCity: CityModel.fromJson(json['toCity']),
      owner: UserModel.fromJson(json['owner']),
      passangers: (json['passangers'] as List<dynamic>)
          .map((passenger) => UserModel.fromJson(passenger))
          .toList(),
      status: json['status'],
      tripDate: json["tripDate"],
      car: CarModel.fromJson(json['car']),
    );
  }
}
