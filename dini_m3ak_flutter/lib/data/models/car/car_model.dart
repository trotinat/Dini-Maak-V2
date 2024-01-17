class CarModel {
  final String id;
  final String carName;
  final String carModel;
  final int maxSeatNumber;

  CarModel({
    required this.id,
    required this.carName,
    required this.carModel,
    required this.maxSeatNumber,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json["id"],
      carName: json['carName'],
      carModel: json["carModel"],
      maxSeatNumber: json["maxSeatNumber"],
    );
  }
}
