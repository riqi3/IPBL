import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lights_up/views/dashboard/pages/tabscreens/main_page.dart';
import 'package:lights_up/views/dashboard/pages/tabs.dart';

import 'constants/app.dart';
import 'views/home/home_screen.dart';

void main() {
  if (kReleaseMode) {
    // do not show debug print messages when running in release mode
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const TabPage(),
    );
  }
}
