import 'package:sudorpc/src/exception/invalid_input_exception.dart';
import 'package:sudorpc/src/structure/return/base.dart';
import 'package:sudorpc/src/structure/return/v1.dart';

SudoRPCReturn createSudoRPCReturnFromJson(Map<String, dynamic> json) {
  if (json['version'] == null) {
    throw SudoRPCInvalidInputException(
      message: "Missing 'version' field in return structure",
      cause: json,
    );
  }

  if (json['version'] == "1.0") {
    if (json['success'] == null) {
      throw SudoRPCInvalidInputException(
        message: "Missing 'success' field in return structure",
        cause: json,
      );
    }

    if (json['success']) {
      try {
        return SudoRPCReturnV1Success.fromJson(json);
      } catch (e) {
        throw SudoRPCInvalidInputException(
          message: 'Failed to parse SudoRPCReturnV1Success from JSON',
          cause: e,
        );
      }
    } else {
      try {
        return SudoRPCReturnV1Fail.fromJson(json);
      } catch (e) {
        throw SudoRPCInvalidInputException(
          message: 'Failed to parse SudoRPCReturnV1Failure from JSON',
          cause: e,
        );
      }
    }
  }
  throw Exception('Unknown version: ${json['version']}');
}
