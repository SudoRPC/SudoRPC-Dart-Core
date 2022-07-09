import 'package:sudorpc/src/structure/return/base.dart';

abstract class SudoRPCReturnV1 extends SudoRPCReturn {
  final String resource;
  final String identifier;

  SudoRPCReturnV1({
    required this.resource,
    required this.identifier,
  }) : super("1.0");
}

class SudoRPCReturnV1Success extends SudoRPCReturnV1 {
  final Map<String, dynamic> result;

  SudoRPCReturnV1Success({
    required this.result,
    required String resource,
    required String identifier,
  }) : super(
          resource: resource,
          identifier: identifier,
        );

  factory SudoRPCReturnV1Success.fromJson(Map<String, dynamic> json) {
    return SudoRPCReturnV1Success(
      result: json['result'],
      resource: json['resource'],
      identifier: json['identifier'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'result': result,
      'resource': resource,
      'identifier': identifier,
    };
  }

  @override
  String toString() {
    return [
      'SudoRPCReturnV1Success{',
      'version: $version,',
      'result: $result,',
      'resource: $resource,',
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
    required String resource,
    required String identifier,
  }) : super(
          resource: resource,
          identifier: identifier,
        );

  factory SudoRPCReturnV1Fail.fromJson(Map<String, dynamic> json) {
    return SudoRPCReturnV1Fail(
      errors: (json['errors'] as List<dynamic>)
          .map((error) => SudoRPCReturnV1ErrorItem.fromJson(error))
          .toList(),
      resource: json['resource'],
      identifier: json['identifier'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'resource': resource,
      'identifier': identifier,
      'errors': errors.map((error) => error.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return [
      'SudoRPCReturnV1Fail{',
      'version: $version,',
      'resource: $resource,',
      'identifier: $identifier,',
      'errors: $errors,',
      '}',
    ].join('\n');
  }
}