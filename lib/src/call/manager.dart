import 'dart:async';

import 'package:sudorpc/src/call/callback.dart';
import 'package:sudorpc/src/call/create.dart';
import 'package:sudorpc/src/call/proxy.dart';
import 'package:sudorpc/src/exception/callback_not_found_exception.dart';
import 'package:sudorpc/src/exception/invalid_return_exception.dart';
import 'package:sudorpc/src/structure/call/base.dart';
import 'package:sudorpc/src/structure/return/base.dart';
import 'package:sudorpc/src/structure/return/v1.dart';
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

  void _listenerCallback({
    required SudoRPCReturn message,
  }) {
    if (message is! SudoRPCReturnV1) {
      throw SudoRPCInvalidReturnException(
        message: 'Invalid return type: ${message.runtimeType}',
        cause: message,
      );
    }

    if (message.success) {
      if (message is! SudoRPCReturnV1Success) {
        throw SudoRPCInvalidReturnException(
          message: 'Invalid return type: ${message.runtimeType}',
          cause: message,
        );
      }

      resolveCall(
        identifier: message.identifier,
        result: message.result,
      );
    } else {
      if (message is! SudoRPCReturnV1Fail) {
        throw SudoRPCInvalidReturnException(
          message: 'Invalid return type: ${message.runtimeType}',
          cause: message,
        );
      }

      rejectCall(
        identifier: message.identifier,
        errors: message.errors,
      );
    }
  }
}
