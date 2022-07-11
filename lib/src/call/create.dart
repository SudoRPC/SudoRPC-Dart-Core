import 'package:sudorpc/src/structure/call/base.dart';
import 'package:sudorpc/src/structure/call/v1.dart';

SudoRPCCall createSudoRPCCall({
  required String resource,
  required String identifier,
  required Map<String, dynamic> metadata,
  required Map<String, dynamic> payload,
}) {
  return SudoRPCCallV1(
    resource: resource,
    identifier: identifier,
    metadata: metadata,
    payload: payload,
  );
}
