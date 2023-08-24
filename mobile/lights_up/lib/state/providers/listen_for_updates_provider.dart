import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../constants/mqtt_topics.dart';
import 'mqtt_client_manager_provider.dart';

final isLightsOnProvider = StateProvider<bool>((ref) => false);

final latestMessageProvider = StateProvider<String?>((ref) => null);

final listenForUpdatesProvider = Provider<void>((ref) {
  final mqttManager = ref.watch(mqttClientManagerProvider);
  mqttManager?.subscribe(kBedRoomLights);
  mqttManager?.getMessagesStream()?.listen((messages) {
    final msg = messages.first.payload as MqttPublishMessage;
    final payload =
        MqttPublishPayload.bytesToStringAsString(msg.payload.message);

    ref.watch(isLightsOnProvider.notifier).state = payload == '1';

    ref.read(latestMessageProvider.notifier).state = payload;
  });
});
