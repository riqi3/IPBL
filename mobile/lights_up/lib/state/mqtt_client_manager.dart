import 'dart:io';

import 'package:flutter/foundation.dart' show debugPrint, immutable;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

@immutable
class MqttClientManager {
  final String server;
  final int port;
  final String username;
  final String password;
  final String clientId;
  final bool useSecure;

  final MqttServerClient _client;

  MqttClientManager({
    required this.server,
    required this.port,
    required this.username,
    required this.password,
    required this.clientId,
    this.useSecure = false,
  }) : _client = MqttServerClient.withPort(server, clientId, port);

  Future<void> connect() async {
    _client.logging(on: true);
    _client.keepAlivePeriod = 30;
    _client.onConnected = onConnected;
    _client.onDisconnected = onDisconnected;
    _client.onSubscribed = onSubscribed;
    _client.onUnsubscribed = onUnsubscribed;
    _client.pongCallback = pong;

    final connMessage =
        MqttConnectMessage().startClean().withWillQos(MqttQos.atLeastOnce);
    _client.connectionMessage = connMessage;
    _client.secure = useSecure;

    try {
      await _client.connect(username, password);
    } on NoConnectionException catch (e) {
      debugPrint('MQTTClient::client exception - $e');
      _client.disconnect();
      rethrow;
    } on SocketException catch (e) {
      debugPrint('MQTTClient::socket exception - $e');
      _client.disconnect();
      rethrow;
    } catch (e) {
      debugPrint('MQTTClient::client exception - $e');
      _client.disconnect();
      rethrow;
    }
  }

  void disconnect() {
    _client.disconnect();
  }

  void subscribe(String topic) {
    _client.subscribe(topic, MqttQos.atLeastOnce);
  }

  void onConnected() {
    debugPrint(
        'MQTTClient::OnConnected client callback - Client connection was sucessful');
  }

  void onDisconnected() {
    debugPrint(
        'MQTTClient::OnDisconnected client callback - Client disconnection');
  }

  void onSubscribed(String topic) {
    debugPrint(
        'MQTTClient::OnSubscribed client callback - Subscription confirmed for topic $topic');
  }

  void onUnsubscribed(String? topic) {
    debugPrint(
        'MQTTClient::OnUnsubscribed client callback - Unsubscription confirmed for topic $topic');
  }

  void pong() {
    debugPrint('MQTTClient::Ping response client callback invoked');
  }

  void publish(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    if (_client.connectionStatus?.state == MqttConnectionState.connected) {
      _client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    }
  }

  Stream<List<MqttReceivedMessage<MqttMessage>>>? getMessagesStream() {
    return _client.updates;
  }
}
