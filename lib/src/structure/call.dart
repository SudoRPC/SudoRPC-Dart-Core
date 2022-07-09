/// @author WMXPY
/// @namespace Structure
/// @description Call

class SudoRPCCall {
  final String version;

  SudoRPCCall(this.version);

  factory SudoRPCCall.fromJson(Map<String, dynamic> json) {
    if (json['version'] == "1.0") {
      return SudoRPCCallV1.fromJson(json);
    }
    throw Exception('Unknown version: ${json['version']}');
  }
}

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
