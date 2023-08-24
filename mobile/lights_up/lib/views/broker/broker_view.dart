import 'package:badges/badges.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badges/badges.dart' as badges;
import '../../constants/app.dart';
import '../../state/enums/app_connection_state.dart';
import '../../state/mqtt_client_manager.dart';
import '../../state/providers/app_connection_state_provider.dart';
import '../../state/providers/is_connected_provider.dart';
import '../../state/providers/mqtt_client_manager_provider.dart';
import '../dashboard/pages/tabs.dart';

class BrokerView extends HookConsumerWidget {
  const BrokerView({super.key});

  void showSnackBar(BuildContext context, String message,
      [int durationInSeconds = 3]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationInSeconds),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serverController = useTextEditingController();
    final portController = useTextEditingController();
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final clientIdController = useTextEditingController();

    const defaultPort = 8883;
    // const defaultserver = 'uc9e97c8.ala.us-east-1.emqxsl.com';
    // const deufa = 'uc9e97c8.ala.us-east-1.emqxsl.com'
    // const defaultPort = 8883;
    final server = useRef('uc9e97c8.ala.us-east-1.emqxsl.com');
    final port = useRef(defaultPort);
    final username = useRef('ipbl-2023');
    final password = useRef('ipbl_5_2023');
    final clientId = useRef('fluttermobile11');
    final useSecure = useState(false);

    useEffect(() {
      serverController.addListener(() {
        server.value = serverController.text;
      });

      portController.text = defaultPort.toString();
      portController.addListener(() {
        port.value = int.tryParse(portController.text) ?? defaultPort;
      });

      usernameController.addListener(() {
        username.value = usernameController.text;
      });

      passwordController.addListener(() {
        password.value = passwordController.text;
      });

      clientIdController.addListener(() {
        clientId.value = clientIdController.text;
      });
      return null;
    }, []);

    void handleMqttClientConnect() {
      if (server.value.isEmpty) {
        showSnackBar(context, 'Server is required');
        return;
      }

      if (clientId.value.isEmpty) {
        // generate a random client id if not provided
        var random = Random();
        clientId.value = 'flutter_client_${random.nextInt(100)}';
      }

      ref.read(mqttClientManagerProvider.notifier).state = MqttClientManager(
        server: server.value,
        port: port.value,
        username: username.value,
        password: password.value,
        clientId: clientId.value,
        useSecure: useSecure.value,
      );

      final isConnected = ref.read(isConnectedProvider);
      if (isConnected) {
        ref.read(mqttClientManagerProvider)?.disconnect();
        ref
            .read(appConnectionStateProvider.notifier)
            .setAppConnectionState(AppConnectionState.disconnected);
      } else {
        ref
            .read(appConnectionStateProvider.notifier)
            .setAppConnectionState(AppConnectionState.connecting);

        ref.read(mqttClientManagerProvider)?.connect().then((_) {
          ref
              .read(appConnectionStateProvider.notifier)
              .setAppConnectionState(AppConnectionState.connected);
        }).catchError((err) {
          ref
              .read(appConnectionStateProvider.notifier)
              .setAppConnectionState(AppConnectionState.error);

          showSnackBar(context, err.toString());
        });
      }
    }

    IconData connStateIcon;
    Color? connStateColor;
    final connState = ref.watch(appConnectionStateProvider);
    switch (connState) {
      case AppConnectionState.connected:
        connStateIcon = Icons.cloud_done_outlined;
        connStateColor = Colors.teal;
        break;

      case AppConnectionState.disconnected:
        connStateIcon = Icons.cloud_off_outlined;
        connStateColor = Colors.brown;
        break;

      case AppConnectionState.connecting:
        connStateIcon = Icons.cloud_upload_outlined;
        connStateColor = Colors.amber;
        break;

      case AppConnectionState.error:
        connStateIcon = Icons.error_outline_outlined;
        connStateColor = Colors.redAccent;
        break;

      default:
        connStateIcon = Icons.cloud_off_outlined;
        connStateColor = Colors.teal;
        break;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/LOGO.png',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(width: 2),
                badges.Badge(
                  badgeContent: Icon(
                    connStateIcon,
                    color: connStateColor,
                    size: 35,
                  ),
                  position: BadgePosition.topEnd(top: 45, end: 18),
                  child: Container(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: serverController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: kStrServer,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: portController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: kStrPort,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: kStrUsername,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: kStrPassword,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: clientIdController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: kStrClientId,
              ),
            ),
            SwitchListTile(
              title: const Text(kStrUseSecure),
              value: useSecure.value,
              onChanged: (value) => useSecure.value = value,
            ),
            connState == AppConnectionState.connecting
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      if (connState == AppConnectionState.connected) {
                        // Navigate to another page here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TabPage(), // Replace with the actual page you want to navigate to
                          ),
                        );
                      } else {
                        // Handle MQTT client connection
                        handleMqttClientConnect();
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 14,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        connState == AppConnectionState.connected
                            ? Colors.brown
                            : Colors.teal,
                      ),
                    ),
                    child: Text(
                      connState == AppConnectionState.connected
                          ? kStrDisconnect
                          : kStrConnect,
                    ),
                  ),
            ElevatedButton(
              onPressed: () {
                if (connState == AppConnectionState.connected) {
                  // Navigate to another page here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TabPage(), // Replace with the actual page you want to navigate to
                    ),
                  );
                } else {
                  // Handle MQTT client connection
                  handleMqttClientConnect();
                }
              },
              child: null,
            ),
          ],
        ),
      ),
    );
  }
}
