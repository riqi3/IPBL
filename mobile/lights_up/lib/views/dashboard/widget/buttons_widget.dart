import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  final Function() onViewInfographicsPressed;
  final Function() onAnotherButtonPressed;

  CustomButtons({
    required this.onViewInfographicsPressed,
    required this.onAnotherButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onViewInfographicsPressed,
          child: Container(
            width: 200,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Materials',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        GestureDetector(
          onTap: onAnotherButtonPressed,
          child: Center(
            child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Notes',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
