import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import '../../constants/app.dart';
import '../broker/broker_view.dart';

import 'connection_state_widget.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final pageIndex = useState(0);

    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (page) => pageController.jumpToPage(page),
      //   currentIndex: pageIndex.value,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.cloud),
      //       label: kTitleBroker,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.cloud_sync),
      //       label: kTitleMissionControl,
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ConnectionStateWidget(),
            BrokerView(),
            // Expanded(
            //   child: PageView(
            //     controller: pageController,
            //     onPageChanged: (page) => pageIndex.value = page,
            //     children: const [
            //       BrokerView(),
            //       MissionControlView(),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
