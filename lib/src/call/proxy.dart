import 'package:sudorpc/src/call/declare.dart';
import 'package:sudorpc/src/structure/call/base.dart';

abstract class SudoRPCCallProxy {
  void send(
    final SudoRPCCall call,
  );

  void addListener(
    final String listenerIdentifier,
    final SudoRPCCallProxyCallback callback,
  );

  void removeListener(
    final String listenerIdentifier,
  );
}
