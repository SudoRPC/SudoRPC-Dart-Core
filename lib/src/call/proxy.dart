import 'package:sudorpc/sudorpc.dart';

abstract class SudoRPCCallProxy<Metadata, Payload, SuccessResult, FailResult> {
  void send(
    SudoRPCCall call,
  );

  void addListener(
    String listenerIdentifier,
  );
}
