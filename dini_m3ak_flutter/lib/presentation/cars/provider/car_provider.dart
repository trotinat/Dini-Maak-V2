import 'package:dini_maak/data/models/car/car_model.dart';
import 'package:dini_maak/data/remote/car_service.dart';
import 'package:dini_maak/di/locator.dart';
import 'package:flutter/material.dart';

class CarProvider extends ChangeNotifier {
  final _carService = locator.get<CarService>();
  late TextEditingController carName;
  late TextEditingController carModel;
  late TextEditingController maxSeatNumber;

  String selectedcar = "Select a car";

  List<CarModel> cars = [];

  bool isAdding = false;
  bool isLoading = false;

  getCars() async {
    isLoading = true;
    List<CarModel> res = await _carService.getAllCars();

    if (cars.isNotEmpty) cars.clear();
    cars.addAll(res);
    selectedcar = res.first.carName;
    isLoading = false;

    notifyListeners();
  }

  Future<bool> createCar() async {
    isAdding = true;
    CarModel? newCar = await _carService.addNewCar(
      carName: carModel.text,
      carModel: carModel.text,
      maxSeatNumber: int.parse(maxSeatNumber.text),
    );

    if (newCar != null) {
      cars.add(newCar);
    }
    isAdding = false;
    notifyListeners();

    return newCar != null;
  }

  onCarChanged(String value) {
    selectedcar = value;
    notifyListeners();
  }

  deleteCard({required CarModel carModel}) async {
    var res = await _carService.deleteCar(carId: carModel.id);

    if (res) {
      cars.removeWhere((element) => element.id == carModel.id);
      notifyListeners();
    }
  }
}
