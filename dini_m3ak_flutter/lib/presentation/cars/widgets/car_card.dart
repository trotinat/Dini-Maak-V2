import 'package:dini_maak/data/models/car/car_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class CarCard extends StatelessWidget {
  final CarModel carModel;
  const CarCard({super.key, required this.carModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(10),
              const Icon(Iconsax.car),
              const Gap(10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    carModel.carName,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    "max seats number : ${carModel.maxSeatNumber}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
