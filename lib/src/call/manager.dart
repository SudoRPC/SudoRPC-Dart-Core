import 'package:sudorpc/sudorpc.dart';

class SudoRPCCallManager {
  final SudoRPCCallProxy proxy;

  final Map<String, SudoRPCCallCallback> _callbacks = Map();
  final Set<String> _listeners = Set();

  SudoRPCCallManager({
    required this.proxy,
  });

  void ignite() {
    final String listenerId =
        'listener_${DateTime.now().millisecondsSinceEpoch}';

    proxy.addListener(listenerId);
  }

  void dialDown() {
    for (final String listenerId in _listeners) {
      proxy.removeListener(listenerId);
    }
    _listeners.clear();
  }
}
