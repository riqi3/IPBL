import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/app.dart';
import '../../state/enums/app_connection_state.dart';
import '../../state/providers/app_connection_state_provider.dart';

class ConnectionStateWidget extends ConsumerWidget {
  const ConnectionStateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connState = ref.watch(appConnectionStateProvider);

    final String statusText;
    final Color bgColor;
    final Color fgColor;

    switch (connState) {
      case AppConnectionState.connected:
        statusText = kStrConnected;
        bgColor = Colors.greenAccent;
        fgColor = Colors.black45;
        break;

      case AppConnectionState.connecting:
        statusText = kStrConnecting;
        bgColor = Colors.amberAccent;
        fgColor = Colors.black87;
        break;

      case AppConnectionState.disconnected:
        statusText = kStrDisconnected;
        bgColor = Colors.redAccent;
        fgColor = Colors.white;
        break;

      case AppConnectionState.error:
        statusText = kStrPleaseTryAgain;
        bgColor = Colors.redAccent;
        fgColor = Colors.white;
        break;
    }

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        statusText,
        textAlign: TextAlign.center,
        style:
            Theme.of(context).textTheme.titleMedium?.copyWith(color: fgColor),
      ),
    );
  }
}
