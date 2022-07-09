class SudoRPCException implements Exception {
  final String message;
  final dynamic cause;

  SudoRPCException({
    required this.message,
    required this.cause,
  });
}
