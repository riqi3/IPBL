// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lights_up/views/dashboard/pages/infographics.dart';
import 'package:lights_up/views/dashboard/widget/buttons_widget.dart';
import 'package:lights_up/views/dashboard/widget/carousel_widget.dart';

import '../notes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80),
            CarouselWithRandomTabs(),
            SizedBox(height: 45),
            CustomButtons(
              onViewInfographicsPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfographicsPage(),
                  ),
                );
              },
              onAnotherButtonPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotesPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
