import 'package:sudorpc/src/exception/exception.dart';

class SudoRPCInvalidInputException implements SudoRPCException {
  @override
  final String message;
  @override
  final dynamic cause;

  SudoRPCInvalidInputException({
    required this.message,
    required this.cause,
  });
}
