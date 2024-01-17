import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PageOne extends StatelessWidget {
  const PageOne({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Text(
            "Dini M3ak",
            style: TextStyle(
              fontFamily: 'Nunito',
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w900,
              fontSize: 40,
            ),
          ),
        ),
        const Gap(30),
        SizedBox(
          height: 250,
          child: Image.asset(image),
        ),
        const Gap(20),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.blue.shade700,
          ),
        ),
        const Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            subTitle,
            textAlign: TextAlign.start,
          ),
        )
      ],
    );
  }
}
