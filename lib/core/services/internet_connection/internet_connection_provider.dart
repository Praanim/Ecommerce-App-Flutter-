import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nattt_bazaar/core/services/internet_connection/internet_connection_notifier.dart';

final internetConnectionProvider =
    StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>(
        (ref) => ConnectivityStatusNotifier());
