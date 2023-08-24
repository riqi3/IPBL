import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';

class CarouselWithRandomTabs extends StatefulWidget {
  @override
  _CarouselWithRandomTabsState createState() => _CarouselWithRandomTabsState();
}

class _CarouselWithRandomTabsState extends State<CarouselWithRandomTabs> {
  final List<Color> tabColors = [
    Color.fromARGB(255, 120, 214, 205),
    Color.fromARGB(255, 126, 215, 129),
    Color.fromARGB(255, 235, 190, 122),
    Color.fromARGB(255, 187, 122, 199),
  ];

  final List<String> helpfulNotes = [
    "Hydroponics is a soilless method of growing plants using nutrient-rich water.",
    "Plants in hydroponic systems receive nutrients directly through water, promoting faster growth.",
    "Maintain proper pH and nutrient levels for optimal hydroponic plant growth.",
    "Consider using LED grow lights to provide the right spectrum of light for plants in hydroponic setups."
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
      ),
      items: tabColors.asMap().entries.map((entry) {
        final index = entry.key;
        final color = entry.value;
        final note = helpfulNotes[index % helpfulNotes.length];

        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      note,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Tip ${index + 1}',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
