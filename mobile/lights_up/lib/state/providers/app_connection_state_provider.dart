import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../enums/app_connection_state.dart';
import '../notifiers/app_connection_state_notifier.dart';

final appConnectionStateProvider =
    StateNotifierProvider<AppConnectionStateNotifier, AppConnectionState>(
  (ref) => AppConnectionStateNotifier(),
);
