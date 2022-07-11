import 'package:sudorpc/src/exception/exception.dart';

class SudoRPCInvalidReturnException implements SudoRPCException {
  @override
  final String message;
  @override
  final dynamic cause;

  SudoRPCInvalidReturnException({
    required this.message,
    required this.cause,
  });
}
