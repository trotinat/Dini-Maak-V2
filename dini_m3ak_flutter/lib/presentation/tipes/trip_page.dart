// ignore_for_file: use_build_context_synchronously
import 'package:dini_maak/presentation/tipes/create_trip_page.dart';
import 'package:dini_maak/presentation/tipes/provider/trip_provider.dart';
import 'package:dini_maak/presentation/tipes/widgets/trip_card.dart';
import 'package:dini_maak/shared/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TripProvider>(context, listen: false).getAllCites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(
          Iconsax.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(CreateTripPage.createTripRoute);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Browse Trip",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (Provider.of<TripProvider>(context, listen: false)
                              .selectedDateTime ==
                          null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Please select a date")));
                      } else if (Provider.of<TripProvider>(context,
                                  listen: false)
                              .selectedFromCity ==
                          Provider.of<TripProvider>(context, listen: false)
                              .selectedDestinationCityName) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    "You must select two different cities")));
                      } else {
                        await Provider.of<TripProvider>(context, listen: false)
                            .getTrips();
                      }
                    },
                    icon: const Icon(Iconsax.search_normal),
                  )
                ],
              ),
            ),
            const Gap(10),
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
            Expanded(
              child: Consumer<TripProvider>(
                builder: (_, data, __) => data.queryTrip.isNotEmpty
                    ? ListView.builder(
                        itemCount: data.queryTrip.length,
                        itemBuilder: (context, index) => TripCrad(
                          buttonText: "Book",
                          isSearchResults: true,
                          tripMode: data.queryTrip[index],
                          onOpenClicked: () async {
                            if (data.queryTrip[index].remainingSeats > 0) {
                              var res = await data.bookTrip(
                                  tripMode: data.queryTrip[index]);

                              if (res) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("Trip booked successfully"),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("You cannot book this trip"),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Trip is full :("),
                                ),
                              );
                            }
                          },
                        ),
                      )
                    : data.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Center(
                            child: Text(
                              "No results",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
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
