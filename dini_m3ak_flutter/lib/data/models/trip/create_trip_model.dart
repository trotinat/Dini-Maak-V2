class CreateTripModel {
  final int tripPrice;
  final int totalSeats;
  final String fromCityId;
  final String toCityId;
  final String tripDate;
  final String cardId;

  CreateTripModel({
    required this.tripPrice,
    required this.totalSeats,
    required this.fromCityId,
    required this.toCityId,
    required this.tripDate,
    required this.cardId,
  });
}
