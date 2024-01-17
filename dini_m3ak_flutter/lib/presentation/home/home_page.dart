// ignore_for_file: use_build_context_synchronously

import 'package:dini_maak/presentation/home/provider/home_provider.dart';
import 'package:dini_maak/presentation/tipes/joined_trip_detals.dart';
import 'package:dini_maak/presentation/tipes/provider/trip_provider.dart';
import 'package:dini_maak/presentation/tipes/trip_details.dart';
import 'package:dini_maak/presentation/tipes/widgets/trip_card.dart';
import 'package:dini_maak/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getUser() async {
    await Provider.of<HomeProvider>(context, listen: false).getUser();
  }

  getMyTrips() async {
    await Provider.of<HomeProvider>(context, listen: false).getMyTrips();
  }

  getJoinedTrips() async {
    await Provider.of<HomeProvider>(context, listen: false).getJoinedTrip();
  }

  @override
  void initState() {
    super.initState();
    getUser();
    getMyTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<HomeProvider>(
          builder: (_, data, __) {
            return data.user == null
                ? const SizedBox()
                : CustomAppBar(
                    userModel: data.user!,
                  );
          },
        ),
        const Divider(),
        const Gap(10),
        Container(
          margin: const EdgeInsets.only(left: 10),
          width: double.infinity,
          child: const Text(
            "My carpooling",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: "Nunito",
            ),
          ),
        ),
        const Gap(10),
        ToggleSwitch(
          minWidth: 500,
          initialLabelIndex: 0,
          totalSwitches: 2,
          activeBgColor: [
            Colors.grey.shade300,
          ],
          labels: const ['My Trips', 'Joined Trip'],
          activeFgColor: Colors.black,
          onToggle: (index) async {
            if (index == 0) {
              //Reservation trips
              await getMyTrips();
              Provider.of<HomeProvider>(context, listen: false)
                  .selectedToggleIndex = 0;
            } else if (index == 1) {
              await getJoinedTrips();
              Provider.of<HomeProvider>(context, listen: false)
                  .selectedToggleIndex = 1;
            }
          },
        ),
        const Gap(10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Consumer<HomeProvider>(
              builder: (_, data, __) => data.trips.isNotEmpty
                  ? ListView.builder(
                      itemCount: data.trips.length,
                      itemBuilder: (context, index) => TripCrad(
                        buttonText: "Open",
                        isSearchResults: false,
                        tripMode: data.trips[index],
                        onOpenClicked: () {
                          if (Provider.of<HomeProvider>(context, listen: false)
                                  .selectedToggleIndex ==
                              0) {
                            Provider.of<TripProvider>(context, listen: false)
                                .tripDetails = data.trips[index];
                            Navigator.of(context)
                                .pushNamed(TripOwnerDetails.tripDetailsRoute);
                          } else {
                            Provider.of<TripProvider>(context, listen: false)
                                .tripDetails = data.trips[index];
                            Navigator.of(context)
                                .pushNamed(JoinedTripDetails.joinedTripDetails);
                          }
                        },
                      ),
                    )
                  : const Center(
                      child: Text("No data"),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
