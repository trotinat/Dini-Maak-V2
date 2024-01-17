// ignore_for_file: use_build_context_synchronously

import 'package:dini_maak/presentation/cars/provider/car_provider.dart';
import 'package:dini_maak/presentation/cars/widgets/car_card.dart';
import 'package:dini_maak/shared/widgets/my_button.dart';
import 'package:dini_maak/shared/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class CarsPage extends StatefulWidget {
  const CarsPage({super.key});

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  late final CarProvider _carProvider;

  getCars() async {
    await Provider.of<CarProvider>(context, listen: false).getCars();
  }

  @override
  void initState() {
    super.initState();
    _carProvider = Provider.of<CarProvider>(context, listen: false);

    _carProvider.carModel = TextEditingController();
    _carProvider.carName = TextEditingController();
    _carProvider.maxSeatNumber = TextEditingController();
    getCars();
  }

  @override
  void dispose() {
    super.dispose();
    _carProvider.carModel.dispose();
    _carProvider.carName.dispose();
    _carProvider.maxSeatNumber.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.car),
                        Gap(10),
                        Text(
                          "Add new car",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),
                    const Gap(10),
                    MyTextField(
                      controller: _carProvider.carName,
                      hintText: "Car name",
                    ),
                    const Gap(10),
                    MyTextField(
                      hintText: "Car model",
                      controller: _carProvider.carModel,
                    ),
                    const Gap(10),
                    MyTextField(
                      controller: _carProvider.maxSeatNumber,
                      hintText: "maxSeatNumber",
                    ),
                    const Gap(10),
                    Consumer<CarProvider>(
                      builder: (_, data, __) => MyButton(
                        color: Colors.black,
                        text: "Add car",
                        onClick: () async {
                          var res = await _carProvider.createCar();
                          Navigator.of(context).pop();
                          if (res) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Car added successfully"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Error occured"),
                              ),
                            );
                          }
                        },
                        textColor: Colors.white,
                        isLoading: data.isAdding,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: const Icon(
          Iconsax.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "My cars",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            Expanded(
              child: Consumer<CarProvider>(
                builder: (_, data, __) => ListView.builder(
                  itemCount: data.cars.length,
                  itemBuilder: (BuildContext context, int index) => Dismissible(
                    onDismissed: (detials) async {
                      await data.deleteCard(carModel: data.cars[index]);
                    },
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    key: Key(data.cars[index].id),
                    child: CarCard(
                      carModel: data.cars[index],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
