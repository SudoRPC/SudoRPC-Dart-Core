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
    return [
      'SudoRPCReturnV1Success{',
      'version: $version,',
      'success: $success,',
      'result: $result,',
      'identifier: $identifier,',
      '}',
    ].join('\n');
  }
}

class SudoRPCReturnV1ErrorItem {
  final bool isInternalError;
  final Map<String, dynamic> result;
  final String error;
  final String message;

  SudoRPCReturnV1ErrorItem({
    required this.isInternalError,
    required this.result,
    required this.error,
    required this.message,
  });

  factory SudoRPCReturnV1ErrorItem.fromJson(Map<String, dynamic> json) {
    return SudoRPCReturnV1ErrorItem(
      isInternalError: json['isInternalError'],
      result: json['result'],
      error: json['error'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isInternalError': isInternalError,
      'result': result,
      'error': error,
      'message': message,
    };
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
    return SudoRPCReturnV1Fail(
      errors: (json['errors'] as List<dynamic>)
          .map((error) => SudoRPCReturnV1ErrorItem.fromJson(error))
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
    return [
      'SudoRPCReturnV1Fail{',
      'version: $version,',
      'success: $success,',
      'identifier: $identifier,',
      'errors: $errors,',
      '}',
    ].join('\n');
  }
}
