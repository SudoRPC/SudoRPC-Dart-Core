import 'dart:async';

import 'package:sudorpc/sudorpc.dart';
import 'package:uuid/uuid.dart';

class SudoRPCCallManager {
  final Uuid uuid = Uuid();

  final SudoRPCCallProxy proxy;

  final Map<String, SudoRPCCallCallback> _callbacks = Map();
  final Set<String> _listeners = Set();

  SudoRPCCallManager({
    required this.proxy,
  });

  void ignite() {
    final String listenerId = uuid.v4();

    proxy.addListener(listenerId);
  }

  void dialDown() {
    for (final String listenerId in _listeners) {
      proxy.removeListener(listenerId);
    }
    _listeners.clear();
  }

  Future<Map<String, dynamic>> makeCall({
    required String resource,
    Map<String, dynamic>? metadata,
    Map<String, dynamic>? payload,
  }) {
    final String identifier = uuid.v4();

    final Completer<Map<String, dynamic>> completer = Completer();

    final SudoRPCCallCallback callback = SudoRPCCallCallback(
      resolver: completer.complete,
      rejector: completer.completeError,
    );

    final Map<String, dynamic> fixedMetadata = metadata ?? {};
    final Map<String, dynamic> fixedPayload = payload ?? {};

    final SudoRPCCall call = createSudoRPCCall(
      resource: resource,
      identifier: identifier,
      metadata: fixedMetadata,
      payload: fixedPayload,
    );

    proxy.send(call);

    return completer.future;
  }
}
