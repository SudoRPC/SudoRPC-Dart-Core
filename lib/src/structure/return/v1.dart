import 'package:sudorpc/src/exception/invalid_input_exception.dart';
import 'package:sudorpc/src/structure/return/base.dart';

abstract class SudoRPCReturnV1 extends SudoRPCReturn {
  final String identifier;

  final bool success;

  SudoRPCReturnV1({
    required this.identifier,
    required this.success,
  }) : super("1.0");
}

class SudoRPCReturnV1Success extends SudoRPCReturnV1 {
  final Map<String, dynamic> result;

  SudoRPCReturnV1Success({
    required this.result,
    required String identifier,
  }) : super(
          identifier: identifier,
          success: true,
        );

  factory SudoRPCReturnV1Success.fromJson(Map<String, dynamic> json) {
    return SudoRPCReturnV1Success(
      result: json['result'],
      identifier: json['identifier'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'success': success,
      'result': result,
      'identifier': identifier,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

abstract class SudoRPCReturnV1ErrorItem {
  final bool isInternalError;
  final String error;
  final String message;

  SudoRPCReturnV1ErrorItem({
    required this.isInternalError,
    required this.error,
    required this.message,
  });

  factory SudoRPCReturnV1ErrorItem.fromJson(Map<String, dynamic> json) {
    if (json['isInternalError'] == null) {
      throw SudoRPCInvalidInputException(
        message: "Missing 'isInternalError' field in return structure",
        cause: json,
      );
    }

    if (json['isInternalError']) {
      return SudoRPCReturnV1InternalErrorItem.fromJson(json);
    } else {
      return SudoRPCReturnV1FailErrorItem.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();
}

class SudoRPCReturnV1InternalErrorItem extends SudoRPCReturnV1ErrorItem {
  SudoRPCReturnV1InternalErrorItem({
    required String error,
    required String message,
  }) : super(
          isInternalError: false,
          error: error,
          message: message,
        );

  factory SudoRPCReturnV1InternalErrorItem.fromJson(Map<String, dynamic> json) {
    return SudoRPCReturnV1InternalErrorItem(
      error: json['error'],
      message: json['message'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'isInternalError': isInternalError,
      'error': error,
      'message': message,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class SudoRPCReturnV1FailErrorItem extends SudoRPCReturnV1ErrorItem {
  final Map<String, dynamic> result;

  SudoRPCReturnV1FailErrorItem({
    required this.result,
    required String error,
    required String message,
  }) : super(
          isInternalError: true,
          error: error,
          message: message,
        );

  factory SudoRPCReturnV1FailErrorItem.fromJson(Map<String, dynamic> json) {
    return SudoRPCReturnV1FailErrorItem(
      result: json['result'],
      error: json['error'],
      message: json['message'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'isInternalError': isInternalError,
      'result': result,
      'error': error,
      'message': message,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class SudoRPCReturnV1Fail extends SudoRPCReturnV1 {
  final List<SudoRPCReturnV1ErrorItem> errors;

  SudoRPCReturnV1Fail({
    required this.errors,
    required String identifier,
  }) : super(
          identifier: identifier,
          success: false,
        );

  factory SudoRPCReturnV1Fail.fromJson(Map<String, dynamic> json) {
    final List<dynamic> errors = json['errors'] as List<dynamic>;
    return SudoRPCReturnV1Fail(
      errors: errors
          .map((errorItem) => SudoRPCReturnV1ErrorItem.fromJson(errorItem))
          .toList(),
      identifier: json['identifier'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'success': success,
      'identifier': identifier,
      'errors': errors.map((error) => error.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
