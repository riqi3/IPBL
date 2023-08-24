// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lights_up/views/dashboard/pages/tabscreens/main_page.dart';
import 'package:lights_up/views/dashboard/pages/tabscreens/phpage.dart';
import 'package:lights_up/views/dashboard/pages/tabscreens/tdspage.dart';
import 'package:lights_up/views/dashboard/pages/tabscreens/wlpage.dart';
import 'package:lights_up/views/home/connection_state_widget.dart';

import '../../broker/broker_view.dart';
import '../../home/home_screen.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<TabPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            // profile screen if any ;/
          },
        ),
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Home'),
            Tab(text: 'PH'),
            Tab(text: 'TDS'),
            Tab(text: 'WL'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                HomePage(),
                PHPage(),
                TDSPage(),
                WLPage(),
              ],
            ),
          ),
          ConnectionStateWidget(),
        ],
      ),
    );
  }
}
