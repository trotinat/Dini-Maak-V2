// ignore_for_file: use_build_context_synchronously

import 'package:dini_maak/presentation/tipes/provider/trip_provider.dart';
import 'package:dini_maak/shared/widgets/my_button.dart';
import 'package:dini_maak/shared/widgets/passager_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class TripOwnerDetails extends StatefulWidget {
  static String tripDetailsRoute = "/tripDetails";

  const TripOwnerDetails({super.key});

  @override
  State<TripOwnerDetails> createState() => _TripOwnerDetailsState();
}

class _TripOwnerDetailsState extends State<TripOwnerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trip details",
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
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 20),
        child: Consumer<TripProvider>(
          builder: (_, data, __) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              data.tripDetails!.owner.profilePicture,
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      SelectableText(
                        data.tripDetails!.owner.username,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 120,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      data.tripDetails!.tripDate.split("T")[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  const Icon(
                    Iconsax.car,
                    size: 30,
                  ),
                  const Gap(10),
                  Text(
                    "${data.tripDetails!.car.carName} ${data.tripDetails!.car.carModel}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  const Icon(Iconsax.location),
                  const Gap(10),
                  Text(
                    data.tripDetails!.fromCity.cityName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              Container(
                height: 30,
                margin: const EdgeInsets.only(left: 11),
                width: 2,
                color: Colors.black,
              ),
              Row(
                children: [
                  const Icon(Iconsax.location),
                  const Gap(10),
                  Text(
                    data.tripDetails!.toCity.cityName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              const Gap(5),
              const Divider(),
              const Gap(5),
              const Text(
                "Passangers",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const Gap(5),
              Expanded(
                child: data.tripDetails!.passangers.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.tripDetails!.passangers.length,
                            itemBuilder: (context, index) => PssagerCard(
                              userModel: data.tripDetails!.passangers[index],
                            ),
                          ),
                          MyButton(
                            color: Colors.black,
                            text: "End",
                            onClick: () async {
                              print("bool");
                              if (await Provider.of<TripProvider>(context,
                                      listen: false)
                                  .closeTrip(tripMode: data.tripDetails!)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Trip endded")));
                              }
                            },
                            textColor: Colors.white,
                            isLoading: false,
                          ),
                        ],
                      )
                    : const Center(
                        child: Text(
                          "No passanger yet !",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
