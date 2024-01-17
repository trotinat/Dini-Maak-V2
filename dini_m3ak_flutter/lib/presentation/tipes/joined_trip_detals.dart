import 'package:dini_maak/presentation/home/home_page.dart';
import 'package:dini_maak/presentation/tipes/provider/trip_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class JoinedTripDetails extends StatefulWidget {
  static String joinedTripDetails = "/joinedTripDetails";
  const JoinedTripDetails({super.key});

  @override
  State<JoinedTripDetails> createState() => _JoinedTripDetailsState();
}

class _JoinedTripDetailsState extends State<JoinedTripDetails> {
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
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10),
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Paid amount : ${Provider.of<TripProvider>(context, listen: false).tripDetails!.tripPrice} MAD",
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
