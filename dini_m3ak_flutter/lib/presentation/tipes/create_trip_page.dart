// ignore_for_file: use_build_context_synchronously

import 'package:dini_maak/presentation/cars/provider/car_provider.dart';
import 'package:dini_maak/presentation/tipes/provider/trip_provider.dart';
import 'package:dini_maak/shared/widgets/my_button.dart';
import 'package:dini_maak/shared/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class CreateTripPage extends StatefulWidget {
  static String createTripRoute = "/createTrip";
  const CreateTripPage({super.key});

  @override
  State<CreateTripPage> createState() => _CreateTripPageState();
}

class _CreateTripPageState extends State<CreateTripPage> {
  late final TripProvider _tripProvider;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _tripProvider = Provider.of<TripProvider>(context, listen: false);
    _tripProvider.tripPrice = TextEditingController();
    _tripProvider.toatlSeats = TextEditingController();
    Provider.of<CarProvider>(context, listen: false).getCars();
  }

  @override
  void dispose() {
    super.dispose();
    _tripProvider.tripPrice.dispose();
    _tripProvider.toatlSeats.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create your trip",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Row(
                children: [
                  Icon(Iconsax.location),
                  Gap(5),
                  Text(
                    "From",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              Consumer<TripProvider>(
                builder: (_, data, __) => DropdownButton(
                  elevation: 20,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: data.cities
                      .map((e) => DropdownMenuItem(
                            value: e.cityName,
                            child: Text(e.cityName),
                          ))
                      .toList(),
                  onChanged: (value) {
                    data.onFromCityChanged(value!);
                  },
                  value: data.selectedFromCity,
                ),
              ),
              const Row(
                children: [
                  Icon(Iconsax.location),
                  Gap(5),
                  Text(
                    "To",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              Consumer<TripProvider>(
                builder: (_, data, __) => DropdownButton(
                  elevation: 20,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: data.cities
                      .map((e) => DropdownMenuItem(
                            value: e.cityName,
                            child: Text(e.cityName),
                          ))
                      .toList(),
                  onChanged: (value) {
                    data.onDestinationCityChanged(value!);
                  },
                  value: data.selectedDestinationCityName,
                ),
              ),
              const Row(
                children: [
                  Icon(Iconsax.car),
                  Gap(5),
                  Text(
                    "Select your car",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              Consumer<CarProvider>(
                builder: (_, data, __) => data.cars.isNotEmpty
                    ? DropdownButton(
                        elevation: 20,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: data.cars
                            .map((e) => DropdownMenuItem(
                                value: e.carName, child: Text(e.carName)))
                            .toList(),
                        onChanged: (value) {
                          data.onCarChanged(value!);
                        },
                        value: data.selectedcar,
                      )
                    : const Text("No data"),
              ),
              const Gap(5),
              MyTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Price is required";
                  }
                  return null;
                },
                textInputType: TextInputType.number,
                controller: _tripProvider.tripPrice,
                hintText: "Price",
              ),
              const Gap(5),
              MyTextField(
                controller: _tripProvider.toatlSeats,
                hintText: "Toal seats",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Number of seats is required";
                  }
                  return null;
                },
                textInputType: TextInputType.number,
              ),
              const Gap(5),
              MyButton(
                color: Colors.black,
                text: "Select date",
                onClick: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2055),
                  );

                  Provider.of<TripProvider>(context, listen: false)
                      .selectedDateTime = selectedDate;
                },
                textColor: Colors.white,
                isLoading: false,
              ),
              const Gap(10),
              MyButton(
                color: Colors.blue,
                text: "Create",
                onClick: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_tripProvider.selectedDestinationCityName ==
                        _tripProvider.selectedFromCity) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("You must chose two diferent cities")));

                      return;
                    }
                    if (_tripProvider.selectedDateTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("You must select a date")));
                      return;
                    }

                    var carProvider =
                        Provider.of<CarProvider>(context, listen: false);
                    String cardId = carProvider.cars
                        .firstWhere((element) =>
                            element.carName == carProvider.selectedcar)
                        .id;
                    var res =
                        await _tripProvider.createTrip(selectedCarId: cardId);
                    if (res) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Trip created successfully")));
                      Navigator.of(context).pop();
                    }
                  }
                },
                textColor: Colors.white,
                isLoading: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
