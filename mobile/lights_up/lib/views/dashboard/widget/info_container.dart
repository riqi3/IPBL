import 'package:flutter/material.dart';

class GreenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      // You can also add an image using an Image.network() widget here
    );
  }
}
