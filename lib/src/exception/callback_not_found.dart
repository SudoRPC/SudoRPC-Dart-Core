import 'package:sudorpc/src/exception/exception.dart';

class SudoRPCCallbackNotFoundException implements SudoRPCException {
  @override
  final String message;
  @override
  final dynamic cause;

  SudoRPCCallbackNotFoundException({
    required this.message,
    required this.cause,
  });
}
