import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../mqtt_client_manager.dart';

final mqttClientManagerProvider =
    StateProvider<MqttClientManager?>((ref) => null);
