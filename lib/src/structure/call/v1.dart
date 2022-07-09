import 'package:sudorpc/src/structure/call/base.dart';

class SudoRPCCallV1<Metadata, Payload> extends SudoRPCCall {
  final String resource;
  final String identifier;

  final Metadata metadata;
  final Payload payload;

  SudoRPCCallV1({
    required this.resource,
    required this.identifier,
    required this.metadata,
    required this.payload,
  }) : super("1.0");

  factory SudoRPCCallV1.fromJson(Map<String, dynamic> json) {
    return SudoRPCCallV1(
      resource: json['resource'],
      identifier: json['identifier'],
      metadata: json['metadata'],
      payload: json['payload'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'resource': resource,
      'identifier': identifier,
      'metadata': metadata,
      'payload': payload,
    };
  }
}
