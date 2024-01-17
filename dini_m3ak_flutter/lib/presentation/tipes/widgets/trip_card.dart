import 'package:dini_maak/data/models/trip/trip_model.dart';
import 'package:dini_maak/presentation/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class TripCrad extends StatelessWidget {
  final TripMode tripMode;
  final Function onOpenClicked;
  final bool isSearchResults;
  final String buttonText;
  const TripCrad({
    super.key,
    required this.tripMode,
    required this.onOpenClicked,
    required this.isSearchResults,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Consumer<HomeProvider>(
        builder: (_, data, __) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(tripMode.owner.profilePicture),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Text(
                        tripMode.owner.username,
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
                        tripMode.fromCity.cityName,
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
                        tripMode.toCity.cityName,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Price",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            "${tripMode.tripPrice} MAD",
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Status",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            tripMode.status,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Date",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            tripMode.tripDate.split("T")[0],
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            isSearchResults
                ? Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red.shade700,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Iconsax.car,
                            color: Colors.white,
                          ),
                          const Gap(10),
                          Text(
                            "Seats left: ${tripMode.remainingSeats}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  onOpenClicked();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green.shade500,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
