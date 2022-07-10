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
}
