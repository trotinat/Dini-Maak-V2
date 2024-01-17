import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyButton extends StatelessWidget {
  final Function onClick;
  final Color color;
  final String text;
  final Color textColor;
  final bool isLoading;

  const MyButton({
    super.key,
    required this.color,
    required this.text,
    required this.onClick,
    required this.textColor,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isLoading) {
          onClick();
        }
      },
      child: Container(
        width: double.infinity,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    color: Colors.white,
                  ),
                  const Gap(20),
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontFamily: "Nunito",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              )
            : Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontFamily: "Nunito",
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
      ),
    );
  }
}
