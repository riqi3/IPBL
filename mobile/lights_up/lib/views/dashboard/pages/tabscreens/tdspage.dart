import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lights_up/constants/app.dart';
import 'package:lights_up/constants/mqtt_topics.dart';
import 'package:lights_up/state/providers/listen_for_updates_provider.dart';
import 'package:lights_up/state/providers/mqtt_client_manager_provider.dart';
import 'package:lights_up/views/dashboard/widget/info_container.dart';

class TDSPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mqttManager = ref.watch(mqttClientManagerProvider);
    bool isLightsOn = ref.watch(isLightsOnProvider);

    useEffect(() {
      ref.watch(listenForUpdatesProvider);
      return null;
    }, const []);
    return Column(
      children: [
        GreenContainer(),
        SizedBox(height: 20),
        Text(
          'PH Page Content',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              Text(
                kStrTurnOnTheLights,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch(
                value: isLightsOn,
                onChanged: (value) {
                  isLightsOn = value;
                  mqttManager?.publish(
                    kBedRoomLights,
                    isLightsOn ? '1' : '0',
                  );
                },
              ),
            ],
          ),
        ),
        Icon(
          Icons.sensors_sharp,
          size: 100,
          color: isLightsOn ? Colors.amber.shade300 : Colors.grey.shade300,
        ),
      ],
    );
  }
}
