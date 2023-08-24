import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lights_up/constants/mqtt_topics.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:lights_up/constants/app.dart';
import 'package:lights_up/state/providers/listen_for_updates_provider.dart';
import 'package:lights_up/state/providers/mqtt_client_manager_provider.dart';

class PHPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightsOn = ref.watch(isLightsOnProvider);
    final latestMessage = ref.watch(latestMessageProvider);

    useEffect(() {
      ref.watch(listenForUpdatesProvider);
      return null;
    }, const []);

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: WebView(
            initialUrl: '',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'PH Page Content',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20),
        ListTile(
          title: Text(latestMessage ?? 'No messages yet'),
        ),
      ],
    );
  }
}
