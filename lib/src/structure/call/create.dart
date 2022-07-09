import 'package:sudorpc/src/exception/invalid_input_exception.dart';
import 'package:sudorpc/src/structure/call/base.dart';
import 'package:sudorpc/src/structure/call/v1.dart';

SudoRPCCall createSudoRPCCallFromJson(Map<String, dynamic> json) {
  if (json['version'] == "1.0") {
    try {
      return SudoRPCCallV1.fromJson(json);
    } catch (e) {
      throw SudoRPCInvalidInputException(
        message: 'Failed to parse SudoRPCCallV1 from JSON',
        cause: e,
      );
    }
  }
  throw Exception('Unknown version: ${json['version']}');
}
