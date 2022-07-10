import 'package:sudorpc/sudorpc.dart';

abstract class SudoRPCCallProxy {
  void send(
    final SudoRPCCall call,
  );

  void addListener(
    final String listenerIdentifier,
  );

  void removeListener(
    final String listenerIdentifier,
  );
}
