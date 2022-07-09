import 'package:sudorpc/src/structure/call/base.dart';
import 'package:sudorpc/sudorpc.dart';

SudoRPCCall createSudoRPCCall() {
  return SudoRPCCallV1(
    resource: '',
    identifier: '',
    metadata: {},
    payload: {},
  );
}
