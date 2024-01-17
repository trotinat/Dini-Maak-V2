import 'package:dini_maak/data/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PssagerCard extends StatelessWidget {
  final UserModel userModel;
  const PssagerCard({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      margin: const EdgeInsets.only(bottom: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(userModel.profilePicture),
              ),
            ),
          ),
          const Gap(10),
          Text(
            userModel.username,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "Nunito",
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
