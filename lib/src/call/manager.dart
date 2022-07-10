import 'dart:async';

import 'package:sudorpc/src/exception/callback_not_found.dart';
import 'package:sudorpc/sudorpc.dart';
import 'package:uuid/uuid.dart';

class SudoRPCCallManager {
  final Uuid uuid = Uuid();

  final SudoRPCCallProxy proxy;

  final Map<String, SudoRPCCallCallback> _callbacks = {};
  final Set<String> _listeners = {};

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

    _callbacks[identifier] = callback;

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

  void resolveCall({
    required String identifier,
    required Map<String, dynamic> result,
  }) {
    if (_callbacks[identifier] == null) {
      throw SudoRPCCallbackNotFoundException(
        message: 'Callback not found for identifier: $identifier',
        cause: identifier,
      );
    }

    final SudoRPCCallCallback callback = _callbacks[identifier]!;

    callback.resolve(result);

    _callbacks.remove(identifier);
  }

  void rejectCall({
    required String identifier,
    required List<SudoRPCReturnV1ErrorItem> errors,
  }) {
    if (_callbacks[identifier] == null) {
      throw SudoRPCCallbackNotFoundException(
        message: 'Callback not found for identifier: $identifier',
        cause: identifier,
      );
    }

    final SudoRPCCallCallback callback = _callbacks[identifier]!;

    callback.reject(errors);

    _callbacks.remove(identifier);
  }
}
