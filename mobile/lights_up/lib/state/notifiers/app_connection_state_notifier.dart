import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../enums/app_connection_state.dart';

class AppConnectionStateNotifier extends StateNotifier<AppConnectionState> {
  AppConnectionStateNotifier() : super(AppConnectionState.disconnected);

  void setAppConnectionState(AppConnectionState connState) => state = connState;
}
