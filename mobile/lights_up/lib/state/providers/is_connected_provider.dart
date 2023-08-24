import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../enums/app_connection_state.dart';
import 'app_connection_state_provider.dart';

final isConnectedProvider = Provider<bool>((ref) {
  final appConnState = ref.watch(appConnectionStateProvider);
  return appConnState == AppConnectionState.connected;
});
