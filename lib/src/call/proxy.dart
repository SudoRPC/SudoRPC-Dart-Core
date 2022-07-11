import 'package:sudorpc/src/structure/call/base.dart';
import 'package:sudorpc/src/structure/return/base.dart';

abstract class SudoRPCCallProxy {
  void send(
    final SudoRPCCall call,
  );

  void addListener(
    final String listenerIdentifier,
    final void Function(SudoRPCReturn message) callback,
  );

  void removeListener(
    final String listenerIdentifier,
  );
}
